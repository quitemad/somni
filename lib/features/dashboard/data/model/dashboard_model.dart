// features/dashboard/data/models/dashboard_model.dart

import 'sleep_session_model.dart';

class DashboardModel {
  final SleepSessionModel? lastSleep;
  final int? weeklyAverageScore;
  final int? totalSleepHours;
  final int? daysTracked;

  DashboardModel({
    this.lastSleep,
    this.weeklyAverageScore,
    this.totalSleepHours,
    this.daysTracked,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    final last = json['last_sleep'];
    final weekly = json['weekly_summary'];
    return DashboardModel(
      lastSleep: last != null ? SleepSessionModel.fromJson(Map<String, dynamic>.from(last)) : null,
      weeklyAverageScore: weekly != null ? (weekly['average_score'] as int?) : null,
      totalSleepHours: weekly != null ? int.parse("${weekly['total_sleep_hours'].ceil()}").ceil() : null,
      daysTracked: weekly != null ? (weekly['days_tracked'] as int?) : null,
    );
  }
}