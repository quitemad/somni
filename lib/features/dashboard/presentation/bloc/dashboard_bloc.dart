// features/dashboard/presentation/bloc/dashboard_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_weekly_scores_usecause.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import '../../domain/usecases/get_dashboard_usecase.dart';
import '../../domain/usecases/get_daily_metrics_usecase.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardUseCase getDashboard;
  final GetWeeklyScoresUseCase getWeeklyScores;
  final GetDailyMetricsUseCase getDailyMetrics;

  DashboardBloc({
    required this.getDashboard,
    required this.getWeeklyScores,
    required this.getDailyMetrics,
  }) : super(DashboardInitial()) {
    on<LoadDashboardRequested>(_onLoad);
  }

  Future<void> _onLoad(LoadDashboardRequested event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    try {
      final dashboard = await getDashboard();
      final weekly = await getWeeklyScores(page: 1);
      final today = DateTime.now();
      final dateStr = "${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}";
      Map<String, dynamic>? metrics;
      try {
        metrics = await getDailyMetrics(dateStr);
      } catch (_) {
        metrics = null;
      }
      emit(DashboardLoaded(dashboard: dashboard, weeklySessions: weekly, todayMetrics: metrics));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}