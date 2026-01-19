import '../../domain/entities/music_prediction_entity.dart';
import '../../domain/repositories/music_repository.dart';
import '../datasources/music_remote_datasource.dart';

class MusicRepositoryImpl implements MusicRepository {
  final MusicRemoteDataSource remote;

  MusicRepositoryImpl(this.remote);

  @override
  Future<MusicPrediction> predictSleepMusic(String query) {
    return remote.predict(query);
  }
}
