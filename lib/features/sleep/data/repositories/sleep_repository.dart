// features/sleep/data/sleep_repository.dart
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

  /// Starts a session: POST /api/sleep and upserts daily metrics. Persists active session locally.
  Future<int> startSessionAndEnsureDailyMetrics() async {
    final now = DateTime.now();
    final dateStr = '${now.year.toString().padLeft(4,'0')}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')}';

    final created = await remote.createSession(date: dateStr, startTime: now);
    final id = (created['id'] is int) ? created['id'] as int : int.tryParse('${created['id']}') ?? 0;

    // Upsert an empty or initial daily metrics object so the dashboard has a record for today.
    try {
      await remote.upsertDailyMetrics(date: dateStr, payload: {'heart_rate': null});
    } catch (_) {
      // ignore daily metrics failures for start; user can retry later
    }

    // persist locally
    await _persistActiveSession(id: id, start: now);
    return id;
  }

  /// Stops session: PUT /api/sleep/{id} with end_time. Clears local persisted session.
  Future<Map<String, dynamic>> stopSession(int id) async {
    final now = DateTime.now();
    final updated = await remote.updateSession(id: id, endTime: now);
    await _clearActiveSession();
    return updated;
  }
}