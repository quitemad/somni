import '../entities/calendar_day_entity.dart';
import '../entities/day_details_entity.dart';

abstract class CalendarRepository {
  Future<List<CalendarDay>> getMonthCalendar({
    required int year,
    required int month,
  });

  Future<DayDetails> getDayDetails(DateTime date);

  Future<void> addNote({
    required DateTime date,
    required String content,
  });

  Future<void> updateTaskStatus({
    required int taskId,
    required bool isCompleted,
  });
}
