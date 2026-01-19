// features/sleep/data/sleep_remote_data_source.dart
import 'package:dio/dio.dart';
import '../../../../core/network/api_constants.dart';

class SleepRemoteDataSource {
  final Dio dio;
  SleepRemoteDataSource(this.dio);

  /// GET /api/sleep/last -> returns last session object or {} / null
  Future<Map<String, dynamic>?> getLastSleep() async {
    final resp = await dio.get(ApiConstants.lastSleep);
    if (resp.data == null) return null;
    if (resp.data is Map<String, dynamic>) return Map<String, dynamic>.from(resp.data as Map);
    return Map<String, dynamic>.from(resp.data as Map);
  }

  /// POST /api/sleep { date, start_time }
  // Future<Map<String, dynamic>> createSession({
  //   required String date,
  //   required DateTime startTime,
  // }) async {
  //   final resp = await dio.post(ApiConstants.sleep, data: {
  //     'date': date,
  //     'start_time': startTime.toIso8601String(),
  //   });
  //   return Map<String, dynamic>.from(resp.data as Map);
  // }
  Future<Map<String, dynamic>> createSession({
    required String date,
    required DateTime startTime,
  }) async {
    final payload = {
      'date': date,
      'start_time': startTime.toIso8601String(),
      'end_time': startTime.add(Duration(days: 1)).toIso8601String(),
    };

    try {
      final resp = await dio.post(ApiConstants.sleep, data: payload);
      return Map<String, dynamic>.from(resp.data as Map);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Failed to start session: ${e.response?.data}');
      }
      throw Exception('Network error starting session: ${e.message}');
    }
  }
  /// PUT /api/sleep/{id} with end_time and optional extras
  Future<Map<String, dynamic>> updateSession({
    required int id,
    required DateTime endTime,
    Map<String, dynamic>? extras,
  }) async {
    final resp = await dio.put('${ApiConstants.sleep}/$id', data: {
      'end_time': endTime.toIso8601String(),
      ...?extras,
    });
    print(resp.data);
    return Map<String, dynamic>.from(resp.data as Map);
  }

  /// PUT /api/daily-metrics/{date} to upsert today's metrics
  Future<Map<String, dynamic>> upsertDailyMetrics({
    required String date,
    Map<String, dynamic>? payload,
  }) async {
    final path = ApiConstants.dailyMetrics.replaceAll('{date}', "");
    final resp = await dio.post(path, data: payload ?? {});
    return Map<String, dynamic>.from(resp.data as Map);
  }

  /// GET /api/daily-metrics/{date}
  Future<Map<String, dynamic>?> getDailyMetrics({required String date}) async {
    final path = ApiConstants.dailyMetrics.replaceAll('{date}', date);
    final resp = await dio.get(path);
    if (resp.data == null) return null;
    print("daily : ${resp.data}");
    return Map<String, dynamic>.from(resp.data as Map);
  }
}