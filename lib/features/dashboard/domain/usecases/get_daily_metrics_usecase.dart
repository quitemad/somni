
import '../reposiotries/dashboard_repository.dart';

class GetDailyMetricsUseCase {
  final DashboardRepository repository;
  GetDailyMetricsUseCase(this.repository);

  Future<Map<String, dynamic>> call(String date) {
    return repository.getDailyMetrics(date);
  }
}