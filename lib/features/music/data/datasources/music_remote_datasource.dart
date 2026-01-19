import '../model/music_prediction_model.dart';

abstract class MusicRemoteDataSource {
  Future<MusicPredictionModel> predict(String query);
}
