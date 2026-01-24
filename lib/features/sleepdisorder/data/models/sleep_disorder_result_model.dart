import '../../domain/entities/sleep_disorder_result.dart';

class SleepDisorderResultModel extends SleepDisorderResult {
  const SleepDisorderResultModel({
    required super.date,
    required super.disorder,
    required super.readableMessage,
    required super.dailyMetricId,
    required super.sleepSessionId,
  });

  factory SleepDisorderResultModel.fromJson(Map<String, dynamic> json) {
    return SleepDisorderResultModel(
      date: json['date'],
      disorder: json['sleep_disorder'],
      readableMessage:
      json['raw']?['Sleep disorders'] ?? json['sleep_disorder'],
      dailyMetricId: json['daily_metric_id'],
      sleepSessionId: json['sleep_session_id'],
    );
  }
}
