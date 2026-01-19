
import '../../domain/entities/calendar_day_entity.dart';

class CalendarDayModel {
  final String date;
  final int? sleepScore;
  final String? aiDisorder;

  CalendarDayModel({
    required this.date,
    this.sleepScore,
    this.aiDisorder,
  });

  factory CalendarDayModel.fromJson(Map<String, dynamic> json) {
    return CalendarDayModel(
      date: json['date'],
      sleepScore: json['sleep_score'],
      aiDisorder: json['ai_disorder'],
    );
  }

  CalendarDay toEntity() {
    return CalendarDay(
      date: DateTime.parse(date),
      sleepScore: sleepScore,
      aiDisorder: aiDisorder,
    );
  }
}
