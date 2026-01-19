
import 'package:shared_preferences/shared_preferences.dart';
import '../datasources/sleep_remote_data_source.dart';

class SleepRepository {
  final SleepRemoteDataSource remote;
  final SharedPreferences prefs;

  static const _kActiveSessionId = 'active_session_id';
  static const _kActiveSessionStart = 'active_session_start';

  SleepRepository(this.remote, this.prefs);

  /// Returns the locally stored active session id (or null)
  int? _localActiveId() => prefs.getInt(_kActiveSessionId);

  String? _localActiveStart() => prefs.getString(_kActiveSessionStart);

  Future<void> _persistActiveSession({required int id, required DateTime start}) async {
    await prefs.setInt(_kActiveSessionId, id);
    await prefs.setString(_kActiveSessionStart, start.toIso8601String());
  }

  Future<void> _clearActiveSession() async {
    await prefs.remove(_kActiveSessionId);
    await prefs.remove(_kActiveSessionStart);
  }

  /// Combined check: use local first, confirm with server (GET /api/sleep/last).
  /// Returns the active session map (from server or local) or null if none.
  Future<Map<String, dynamic>?> getOngoingSession() async {
    final localId = _localActiveId();
    try {
      final last = await remote.getLastSleep();
      if (last != null && last.isNotEmpty) {
        // If server last session has no end_time => active
        final endTime = last['end_time'];
        final serverId = (last['id'] is int) ? last['id'] as int : int.tryParse('${last['id']}');
        if (endTime == null) {
          // Persist server active session locally if not present
          if (serverId != null) {
            final startStr = last['start_time'] as String?;
            final start = startStr != null ? DateTime.tryParse(startStr) ?? DateTime.now() : DateTime.now();
            await _persistActiveSession(id: serverId, start: start);
          }
          return last;
        } else {
          // server last ended -> clear local if it matches
          if (localId != null && serverId == localId) {
            await _clearActiveSession();
          }
          return null;
        }
      } else {
        // No server last session: fall back to local info (offline or not created)
        if (localId != null) {
          final startStr = _localActiveStart();
          return {
            'id': localId,
            'start_time': startStr ?? DateTime.now().toIso8601String(),
          };
        }
        return null;
      }
    } catch (e) {
      // Network error: fall back to local persisted info (so user can continue)
      if (localId != null) {
        final startStr = _localActiveStart();
        return {
          'id': localId,
          'start_time': startStr ?? DateTime.now().toIso8601String(),
        };
      }
      return null;
    }
  }

  /// Starts a session: POST /api/sleep. Persists active session locally.
  /// (Daily metrics upsert has been moved to stopSession — see stopSession() below.)
  Future<int> startSessionAndEnsureDailyMetrics() async {
    final now = DateTime.now();
    final dateStr = '${now.year.toString().padLeft(4,'0')}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')}';

    final created = await remote.createSession(date: dateStr, startTime: now);
    final id = (created['id'] is int) ? created['id'] as int : int.tryParse('${created['id']}') ?? 0;

    // persist locally
    await _persistActiveSession(id: id, start: now);
    return id;
  }

  /// Stops session: PUT /api/sleep/{id} with end_time. Clears local persisted session.
  /// Also upserts daily metrics for the session date (moved here from start).
  Future<Map<String, dynamic>> stopSession(int id) async {
    final now = DateTime.now();
    final updated = await remote.updateSession(id: id, endTime: now);

    // Try to compute / extract the date and duration to upsert daily metrics.
    try {
      // Prefer server-provided date field if available, otherwise use endTime's date
      String? rawDate = updated['date'] as String?;
      DateTime dateDt;
      if (rawDate != null && rawDate.isNotEmpty) {
        // rawDate may be just a date or a datetime
        dateDt = DateTime.tryParse(rawDate) ?? DateTime.now();
      } else {
        dateDt = now;
      }
      final dateStr = '${dateDt.year.toString().padLeft(4,'0')}-${dateDt.month.toString().padLeft(2,'0')}-${dateDt.day.toString().padLeft(2,'0')}';

      // Attempt to get start_time and end_time from server response; fall back to local values
      final startStr = updated['start_time'] as String?;
      final endStr = updated['end_time'] as String?;
      DateTime? startDt = startStr != null ? DateTime.tryParse(startStr) : null;
      DateTime? endDt = endStr != null ? DateTime.tryParse(endStr) : null;
      // If server didn't return duration, compute it
      int? durationMinutes;
      if (endDt != null && startDt != null) {
        durationMinutes = endDt.difference(startDt).inMinutes;
      } else if (startDt == null && endDt != null) {
        // try local persisted start
        final localStart = _localActiveStart();
        if (localStart != null) {
          final localStartDt = DateTime.tryParse(localStart);
          if (localStartDt != null) {
            durationMinutes = endDt.difference(localStartDt).inMinutes;
          }
        }
      }

      // Compose payload according to backend expectations (use common keys)
      final payload = <String, dynamic>{
        if (durationMinutes != null) 'sleep_duration_minutes': durationMinutes,
        if (updated.containsKey('sleep_score')) 'sleep_score': updated['sleep_score'],
        if (updated.containsKey('sleep_quality')) 'quality_of_sleep': updated['sleep_quality'],
        "date":dateStr
      };

      // Only call upsert if we have something useful to send
      if (payload.isNotEmpty) {
        // remote.upsertDailyMetrics uses PUT /api/daily-metrics/{date}
        await remote.upsertDailyMetrics(date: dateStr, payload: payload);
      }
    } catch (_) {
      // ignore failures for metrics upsert - stopping session must succeed regardless
    }

    await _clearActiveSession();
    return updated;
  }
}