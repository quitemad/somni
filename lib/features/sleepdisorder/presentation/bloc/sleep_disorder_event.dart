import 'package:equatable/equatable.dart';

abstract class SleepDisorderEvent extends Equatable {
  const SleepDisorderEvent();

  @override
  List<Object?> get props => [];
}

class DetectSleepDisorderEvent extends SleepDisorderEvent {
  final Map<String, dynamic> payload;

  const DetectSleepDisorderEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}
