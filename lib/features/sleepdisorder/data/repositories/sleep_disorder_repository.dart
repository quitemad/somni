import '../../domain/entities/sleep_disorder_result.dart';

abstract class SleepDisorderRepository {
  Future<SleepDisorderResult> detect(Map<String, dynamic> body);
}
