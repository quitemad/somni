import 'dart:io';
import '../entities/stress_result_entity.dart';
import '../repositories/stress_repository.dart';

class DetectStressFromImageUseCase {
  final StressRepository repository;

  DetectStressFromImageUseCase(this.repository);

  Future<StressResultEntity> call({
    required File image,
    DateTime? date,
  }) {
    return repository.detectStressFromImage(
      image: image,
      date: date,
    );
  }
}
