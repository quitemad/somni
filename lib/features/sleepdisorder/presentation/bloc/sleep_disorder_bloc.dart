import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somni/features/sleepdisorder/presentation/bloc/sleep_disorder_event.dart';
import 'package:somni/features/sleepdisorder/presentation/bloc/sleep_disorder_state.dart';

import '../../domain/usecases/detect_sleep_dsorder_usecase.dart';

class SleepDisorderBloc
    extends Bloc<SleepDisorderEvent, SleepDisorderState> {
  final DetectSleepDisorderUseCase detect;

  SleepDisorderBloc({required this.detect})
      : super(SleepDisorderInitial()) {
    on<DetectSleepDisorderEvent>((event, emit) async {
      emit(SleepDisorderLoading());
      try {
        final result = await detect(event.payload);
        emit(SleepDisorderLoaded(result));
      } catch (e) {
        emit(SleepDisorderError(e.toString()));
      }
    });
  }
}
