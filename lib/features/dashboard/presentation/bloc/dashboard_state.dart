// features/dashboard/presentation/bloc/dashboard_state.dart

import '../../data/model/dashboard_model.dart';
import '../../data/model/sleep_session_model.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardModel dashboard;
  final List<SleepSessionModel> weeklySessions;
  final Map<String, dynamic>? todayMetrics;

  DashboardLoaded({
    required this.dashboard,
    required this.weeklySessions,
    this.todayMetrics,
  });
}

class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}