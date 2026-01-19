class MusicPrediction {
  final bool isSleepSuitable;
  final double probability;
  final String message;
  final String trackName;

  const MusicPrediction({
    required this.isSleepSuitable,
    required this.probability,
    required this.message,
    required this.trackName,
  });
}
