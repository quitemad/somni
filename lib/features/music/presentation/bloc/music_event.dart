abstract class MusicEvent {}

class PredictMusicEvent extends MusicEvent {
  final String query;
  PredictMusicEvent(this.query);
}
