import '../../data/repositories/sleep_disorder_repository.dart';
import '../entities/sleep_disorder_result.dart';

class DetectSleepDisorderUseCase {
  final SleepDisorderRepository repository;

  DetectSleepDisorderUseCase(this.repository);

  Future<SleepDisorderResult> call(Map<String, dynamic> body) {
    return repository.detect(body);
  }
}
