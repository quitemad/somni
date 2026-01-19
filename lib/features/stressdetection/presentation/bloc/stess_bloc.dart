import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/detect_stress_from_image_usecase.dart';
import 'stress_event.dart';
import 'stress_state.dart';

class StressBloc extends Bloc<StressEvent, StressState> {
  final DetectStressFromImageUseCase detectStress;

  StressBloc({required this.detectStress}) : super(StressInitial()) {
    on<DetectStressFromImage>(_onDetectStress);
  }

  Future<void> _onDetectStress(
      DetectStressFromImage event,
      Emitter<StressState> emit,
      ) async {
    emit(StressLoading());

    try {
      final result = await detectStress(
        image: event.image,
        date: event.date,
      );

      emit(StressLoaded(result));
    } catch (e) {
      emit(
        StressError(
          e is Exception ? e.toString() : 'Failed to detect stress',
        ),
      );
    }
  }
}
