import 'dart:io';

import '../../domain/entities/stress_result_entity.dart';
import '../../domain/repositories/stress_repository.dart';
import '../datasources/stress_remote_datasource.dart';
import '../models/stress_result_model.dart';

class StressRepositoryImpl implements StressRepository {
  final StressRemoteDataSource remote;

  StressRepositoryImpl(this.remote);

  @override
  Future<StressResultEntity> detectStressFromImage({
    required File image,
    DateTime? date,
  }) async {
    final raw = await remote.detectStressFromImage(
      image: image,
      date: date,
    );

    final model = StressResultModel.fromJson(raw);
    return model.toEntity();
  }
}
