import 'package:equatable/equatable.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object?> get props => [];
}

/// Load month calendar
class LoadMonthCalendar extends CalendarEvent {
  final int year;
  final int month;

  const LoadMonthCalendar({
    required this.year,
    required this.month,
  });

  @override
  List<Object?> get props => [year, month];
}

/// User taps a day
class SelectDay extends CalendarEvent {
  final DateTime date;

  const SelectDay(this.date);

  @override
  List<Object?> get props => [date];
}

/// Add note for a day
class AddNoteEvent extends CalendarEvent {
  final DateTime date;
  final String content;

  const AddNoteEvent({
    required this.date,
    required this.content,
  });

  @override
  List<Object?> get props => [date, content];
}

/// Toggle task completion
class UpdateTaskStatusEvent extends CalendarEvent {
  final int taskId;
  final bool isCompleted;

  const UpdateTaskStatusEvent({
    required this.taskId,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [taskId, isCompleted];
}
