import '../entities/music_prediction_entity.dart';
import '../repositories/music_repository.dart';

class PredictMusicUseCase {
  final MusicRepository repository;

  PredictMusicUseCase(this.repository);

  Future<MusicPrediction> call(String query) {
    return repository.predictSleepMusic(query);
  }
}
