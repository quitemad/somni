import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/predict_music_usecase.dart';
import 'music_event.dart';
import 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  final PredictMusicUseCase predictMusic;

  MusicBloc({required this.predictMusic}) : super(MusicInitial()) {
    on<PredictMusicEvent>(_onPredict);
  }

  Future<void> _onPredict(
      PredictMusicEvent event,
      Emitter<MusicState> emit,
      ) async {
    emit(MusicLoading());

    try {
      final result = await predictMusic(event.query);
      emit(MusicLoaded(result));
    } catch (e) {
      emit(MusicError('Failed to analyze music'));
    }
  }
}
