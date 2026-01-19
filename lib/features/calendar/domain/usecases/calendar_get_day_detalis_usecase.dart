import '../entities/day_details_entity.dart';
import '../repositories/calendar_repository.dart';

class GetDayDetailsUseCase {
  final CalendarRepository repository;

  GetDayDetailsUseCase(this.repository);

  Future<DayDetails> call(DateTime date) {
    return repository.getDayDetails(date);
  }
}
