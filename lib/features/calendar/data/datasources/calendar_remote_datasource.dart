abstract class CalendarRemoteDataSource {
  Future<List<dynamic>> getMonthCalendar({
    required int year,
    required int month,
  });

  Future<Map<String, dynamic>> getDayDetails(DateTime date);

  Future<void> addNote({
    required DateTime date,
    required String content,
  });

  Future<void> updateTaskStatus({
    required int taskId,
    required bool isCompleted,
  });
}
