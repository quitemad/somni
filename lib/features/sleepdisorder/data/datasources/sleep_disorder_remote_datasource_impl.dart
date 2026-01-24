import 'package:dio/dio.dart';
import 'package:somni/core/network/api_constants.dart';
import 'package:somni/features/sleepdisorder/data/datasources/sleep_disorder_remote_datasource.dart';

import '../models/sleep_disorder_result_model.dart';

class SleepDisorderRemoteDataSourceImpl
    implements SleepDisorderRemoteDataSource {
  final Dio dio;

  SleepDisorderRemoteDataSourceImpl(this.dio);

  @override
  Future<SleepDisorderResultModel> detect(
      Map<String, dynamic> body) async {
    final response = await dio.post(ApiConstants.sleepDisorder,
      data: body,
    );

    return SleepDisorderResultModel.fromJson(response.data);
  }
}
