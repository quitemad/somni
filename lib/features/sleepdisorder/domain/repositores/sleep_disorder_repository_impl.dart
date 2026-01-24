import '../../data/repositories/sleep_disorder_repository.dart';
import '../entities/sleep_disorder_result.dart';
import '../../data/datasources/sleep_disorder_remote_datasource.dart';

class SleepDisorderRepositoryImpl implements SleepDisorderRepository {
  final SleepDisorderRemoteDataSource remote;

  SleepDisorderRepositoryImpl(this.remote);

  @override
  Future<SleepDisorderResult> detect(Map<String, dynamic> body) {
    return remote.detect(body);
  }
}
