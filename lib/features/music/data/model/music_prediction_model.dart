import '../../domain/entities/music_prediction_entity.dart';

class MusicPredictionModel extends MusicPrediction {
  MusicPredictionModel({
    required super.isSleepSuitable,
    required super.probability,
    required super.message,
    required super.trackName,
  });

  factory MusicPredictionModel.fromJson(Map<String, dynamic> json) {
    return MusicPredictionModel(
      isSleepSuitable: json['is_sleep_suitable'],
      probability: (json['probability'] as num).toDouble(),
      message: json['message'],
      trackName: json['track_name'],
    );
  }
}
