import 'package:equatable/equatable.dart';
import '../../domain/entities/stress_result_entity.dart';

abstract class StressState extends Equatable {
  const StressState();

  @override
  List<Object?> get props => [];
}

class StressInitial extends StressState {}

class StressLoading extends StressState {}

class StressLoaded extends StressState {
  final StressResultEntity result;

  const StressLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class StressError extends StressState {
  final String message;

  const StressError(this.message);

  @override
  List<Object?> get props => [message];
}
