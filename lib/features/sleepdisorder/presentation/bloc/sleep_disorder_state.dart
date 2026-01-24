import 'package:equatable/equatable.dart';
import '../../domain/entities/sleep_disorder_result.dart';

abstract class SleepDisorderState extends Equatable {
  const SleepDisorderState();

  @override
  List<Object?> get props => [];
}

class SleepDisorderInitial extends SleepDisorderState {
  const SleepDisorderInitial();
}

class SleepDisorderLoading extends SleepDisorderState {
  const SleepDisorderLoading();
}

class SleepDisorderLoaded extends SleepDisorderState {
  final SleepDisorderResult result;

  const SleepDisorderLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class SleepDisorderError extends SleepDisorderState {
  final String message;

  const SleepDisorderError(this.message);

  @override
  List<Object?> get props => [message];
}
