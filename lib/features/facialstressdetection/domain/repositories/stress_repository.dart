import 'dart:io';
import '../entities/stress_result_entity.dart';

abstract class StressRepository {
  Future<StressResultEntity> detectStressFromImage({
    required File image,
    DateTime? date,
  });
}
