import '../models/sleep_disorder_result_model.dart';

abstract class SleepDisorderRemoteDataSource {
  Future<SleepDisorderResultModel> detect(Map<String, dynamic> body);
}
