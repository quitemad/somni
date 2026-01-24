import '../../domain/entities/stress_result_entity.dart';

class StressResultModel {
  final int stressLevel;
  final String label;
  final String description;
  final double confidence;
  final String? date;

  StressResultModel({
    required this.stressLevel,
    required this.label,
    required this.description,
    required this.confidence,
    this.date,
  });

  factory StressResultModel.fromJson(Map<String, dynamic> json) {
    return StressResultModel(
      stressLevel: json['stress_level'] ?? 0,
      label: json['label'] ?? '',
      description: json['description'] ?? '',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      date: json['date'],
    );
  }

  StressResultEntity toEntity() {
    return StressResultEntity(
      stressLevel: stressLevel,
      label: label,
      description: description,
      confidence: confidence,
      date: date,
    );
  }
}
