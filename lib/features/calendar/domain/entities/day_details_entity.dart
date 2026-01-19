import 'package:somni/features/calendar/domain/entities/pre_sleep_task_entity.dart';

import 'notes_entity.dart';

class DayDetails {
  final int? sleepScore;
  final String? aiDisorder;
  final List<Note> notes;
  final List<PreSleepTask> tasks;

  const DayDetails({
    this.sleepScore,
    this.aiDisorder,
    required this.notes,
    required this.tasks,
  });
}
