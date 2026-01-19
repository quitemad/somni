import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../../core/network/api_constants.dart';
import 'calendar_remote_datasource.dart';

class CalendarRemoteDataSourceImpl implements CalendarRemoteDataSource {
  final Dio dio;

  CalendarRemoteDataSourceImpl(this.dio);

  @override
  Future<List<dynamic>> getMonthCalendar({
    required int year,
    required int month,
  }) async {
    final res = await dio.get(
      ApiConstants.calendar,
      queryParameters: {
        'year': year,
        'month': month,
      },
    );

    final map = Map<String, dynamic>.from(res.data ?? {});
    final list = map['data'] as List<dynamic>? ?? [];

    return list;
  }


  @override
  Future<Map<String, dynamic>> getDayDetails(DateTime date) async {
    final res = await dio.get(
      ApiConstants.calendarDayDetails,
      queryParameters: {
        'date': date.toIso8601String(),
      },
    );
Logger().w(res.data);
    return Map<String, dynamic>.from(res.data ?? {});
  }

  @override
  Future<void> addNote({
    required DateTime date,
    required String content,
  }) async {
    await dio.post(
      ApiConstants.notes,
      data: {
        'date': date.toIso8601String(),
        'content': content,
      },
    );
  }

  @override
  Future<void> updateTaskStatus({
    required int taskId,
    required bool isCompleted,
  }) async {
    await dio.put(
      '${ApiConstants.tasks}/$taskId',
      data: {
        'completed': isCompleted,
      },
    );
  }
}
