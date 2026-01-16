// features/dashboard/data/models/sleep_session_model.dart

class SleepSessionModel {
  final int id;
  final DateTime? date;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? durationMinutes;
  final int? sleepQuality;
  final int? sleepScore;
  final String? aiDisorder;
  final String? scoreCategory;

  SleepSessionModel({
    required this.id,
    this.date,
    this.startTime,
    this.endTime,
    this.durationMinutes,
    this.sleepQuality,
    this.sleepScore,
    this.aiDisorder,
    this.scoreCategory,
  });

  factory SleepSessionModel.fromJson(Map<String, dynamic> json) {
    DateTime? parse(String? v) => v == null ? null : DateTime.tryParse(v);
    return SleepSessionModel(
      id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
      date: json['date'] != null ? parse(json['date'] is String ? json['date'] : json['date'].toString()) : null,
      startTime: parse(json['start_time'] as String?),
      endTime: parse(json['end_time'] as String?),
      durationMinutes: json['sleep_duration_minutes'] is int ? json['sleep_duration_minutes'] : (json['duration_minutes'] as int?),
      sleepQuality: json['sleep_quality'] as int?,
      sleepScore: json['sleep_score'] as int?,
      aiDisorder: json['ai_disorder'] as String?,
      scoreCategory: json['score_category'] as String?,
    );
  }
}