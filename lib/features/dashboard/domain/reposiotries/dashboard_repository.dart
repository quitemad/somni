// features/dashboard/domain/repositories/dashboard_repository.dart

import '../../data/model/dashboard_model.dart';
import '../../data/model/sleep_session_model.dart';

abstract class DashboardRepository {
  Future<DashboardModel> getDashboard();
  Future<SleepSessionModel?> getLastSleep();
  /// returns list of recent sleep sessions (used to compute weekly scores)
  Future<List<SleepSessionModel>> listSleepSessions({int page = 1});
  /// daily metrics (map)
  Future<Map<String, dynamic>> getDailyMetrics(String date);
}