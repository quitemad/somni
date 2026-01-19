import '../entities/calendar_day_entity.dart';
import '../repositories/calendar_repository.dart';

class GetMonthCalendarUseCase {
  final CalendarRepository repository;

  GetMonthCalendarUseCase(this.repository);

  Future<List<CalendarDay>> call({
    required int year,
    required int month,
  }) {
    return repository.getMonthCalendar(
      year: year,
      month: month,
    );
  }
}
