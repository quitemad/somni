import '../entities/music_prediction_entity.dart';

abstract class MusicRepository {
  Future<MusicPrediction> predictSleepMusic(String query);
}
