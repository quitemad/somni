// features/dashboard/domain/usecases/get_dashboard_usecase.dart

import '../../data/model/dashboard_model.dart';
import '../reposiotries/dashboard_repository.dart';

class GetDashboardUseCase {
  final DashboardRepository repository;
  GetDashboardUseCase(this.repository);

  Future<DashboardModel> call() {
    return repository.getDashboard();
  }
}