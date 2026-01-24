class StressResultEntity {
  final int stressLevel; // numeric level from backend
  final String label; // low / medium / high
  final String description;
  final double confidence;
  final String? date;

  const StressResultEntity({
    required this.stressLevel,
    required this.label,
    required this.description,
    required this.confidence,
    this.date,
  });
}
