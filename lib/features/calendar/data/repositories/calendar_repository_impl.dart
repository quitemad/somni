import '../../domain/entities/calendar_day_entity.dart';
import '../../domain/entities/day_details_entity.dart';
import '../../domain/repositories/calendar_repository.dart';
import '../datasources/calendar_remote_datasource.dart';
import '../model/calendar_day_model.dart';
import '../model/day_details_model.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  final CalendarRemoteDataSource remote;

  CalendarRepositoryImpl(this.remote);

  @override
  Future<List<CalendarDay>> getMonthCalendar({
    required int year,
    required int month,
  }) async {
    final rawList = await remote.getMonthCalendar(
      year: year,
      month: month,
    );

    return rawList
        .map((e) => CalendarDayModel.fromJson(e).toEntity())
        .toList();
  }

  @override
  Future<DayDetails> getDayDetails(DateTime date) async {
    final raw = await remote.getDayDetails(date);
    return DayDetailsModel.fromJson(raw).toEntity();
  }

  @override
  Future<void> addNote({
    required DateTime date,
    required String content,
  }) {
    return remote.addNote(date: date, content: content);
  }

  @override
  Future<void> updateTaskStatus({
    required int taskId,
    required bool isCompleted,
  }) {
    return remote.updateTaskStatus(
      taskId: taskId,
      isCompleted: isCompleted,
    );
  }
}
