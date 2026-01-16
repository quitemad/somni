// features/dashboard/data/repositories/dashboard_repository_impl.dart

import '../../domain/reposiotries/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';
import '../model/dashboard_model.dart';
import '../model/sleep_session_model.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remote;

  DashboardRepositoryImpl(this.remote);

  @override
  Future<DashboardModel> getDashboard() async {
    final data = await remote.getDashboard();
    return DashboardModel.fromJson(data);
  }

  @override
  Future<SleepSessionModel?> getLastSleep() async {
    final data = await remote.getLastSleep();
    // depending on API response: sometimes the last endpoint returns the object directly
    if (data.isEmpty) return null;
    return SleepSessionModel.fromJson(Map<String, dynamic>.from(data));
  }

  @override
  Future<List<SleepSessionModel>> listSleepSessions({int page = 1}) async {
    final data = await remote.listSleepSessions(page: page);
    final list = data['data'] as List<dynamic>? ?? [];
    return list.map((e) => SleepSessionModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  @override
  Future<Map<String, dynamic>> getDailyMetrics(String date) async {
    final data = await remote.getDailyMetrics(date);
    return data;
  }
}