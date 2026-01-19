import '../../domain/entities/day_details_entity.dart';
import 'note_model.dart';
import 'pre_sleep_task_model.dart';

class DayDetailsModel {
  final int? sleepScore;
  final String? aiDisorder;
  final List<NoteModel> notes;
  final List<PreSleepTaskModel> tasks;

  DayDetailsModel({
    this.sleepScore,
    this.aiDisorder,
    required this.notes,
    required this.tasks,
  });

  factory DayDetailsModel.fromJson(Map<String, dynamic> json) {
    return DayDetailsModel(
      sleepScore: json['sleep_score'] == null
          ? null
          : int.tryParse(json['sleep_score'].toString()),
      aiDisorder: json['ai_disorder'] as String?,
      notes: (json['notes'] as List? ?? [])
          .map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tasks: (json['tasks'] as List? ?? [])
          .map((e) => PreSleepTaskModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  DayDetails toEntity() {
    return DayDetails(
      sleepScore: sleepScore,
      aiDisorder: aiDisorder,
      notes: notes.map((e) => e.toEntity()).toList(),
      tasks: tasks.map((e) => e.toEntity()).toList(),
    );
  }
}
