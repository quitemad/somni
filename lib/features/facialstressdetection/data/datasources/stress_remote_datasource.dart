import 'dart:io';

abstract class StressRemoteDataSource {
  Future<Map<String, dynamic>> detectStressFromImage({
    required File image,
    DateTime? date,
  });
}
