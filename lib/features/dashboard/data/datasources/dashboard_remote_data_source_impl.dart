// features/dashboard/data/datasources/dashboard_remote_data_source_impl.dart

import 'package:dio/dio.dart';
import '../../../../core/network/api_constants.dart';
import 'dashboard_remote_data_source.dart';

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio dio;

  DashboardRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> getDashboard() async {
    final response = await dio.get(ApiConstants.dashboard);
    return Map<String, dynamic>.from(response.data as Map);
  }

  @override
  Future<Map<String, dynamic>> listSleepSessions({int page = 1}) async {
    final response = await dio.get(
      ApiConstants.sleep,
      queryParameters: {'page': page},
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  @override
  Future<Map<String, dynamic>> getLastSleep() async {
    final response = await dio.get(ApiConstants.lastSleep);
    return Map<String, dynamic>.from(response.data as Map);
  }

  @override
  Future<Map<String, dynamic>> getDailyMetrics(String date) async {
    final path = ApiConstants.dailyMetrics.replaceAll('{date}', date);
    final response = await dio.get(path);
    return Map<String, dynamic>.from(response.data as Map);
  }
}