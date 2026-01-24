import 'package:equatable/equatable.dart';

class SleepDisorderResult extends Equatable {
  final String date;
  final String disorder;
  final String readableMessage;
  final int? dailyMetricId;
  final int? sleepSessionId;

  const SleepDisorderResult({
    required this.date,
    required this.disorder,
    required this.readableMessage,
    required this.dailyMetricId,
    required this.sleepSessionId,
  });

  @override
  List<Object?> get props => [
    date,
    disorder,
    readableMessage,
    dailyMetricId,
    sleepSessionId,
  ];
}
