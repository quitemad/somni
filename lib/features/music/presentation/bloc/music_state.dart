import '../../domain/entities/music_prediction_entity.dart';

abstract class MusicState {}

class MusicInitial extends MusicState {}

class MusicLoading extends MusicState {}

class MusicLoaded extends MusicState {
  final MusicPrediction prediction;
  MusicLoaded(this.prediction);
}

class MusicError extends MusicState {
  final String message;
  MusicError(this.message);
}
