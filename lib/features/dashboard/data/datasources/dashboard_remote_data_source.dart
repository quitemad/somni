// features/dashboard/data/datasources/dashboard_remote_data_source.dart

abstract class DashboardRemoteDataSource {
  /// GET /api/dashboard
  Future<Map<String, dynamic>> getDashboard();

  /// GET /api/sleep?page=1  (or other page)
  Future<Map<String, dynamic>> listSleepSessions({int page = 1});

  /// GET /api/sleep/last
  Future<Map<String, dynamic>> getLastSleep();

  /// GET /api/daily-metrics/{date}
  Future<Map<String, dynamic>> getDailyMetrics(String date);
}