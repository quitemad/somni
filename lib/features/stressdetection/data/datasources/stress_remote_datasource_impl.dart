import 'dart:io';

import 'package:dio/dio.dart';
import '../../../../core/network/api_constants.dart';
import 'stress_remote_datasource.dart';

class StressRemoteDataSourceImpl implements StressRemoteDataSource {
  final Dio dio;

  StressRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> detectStressFromImage({
    required File image,
    DateTime? date,
  }) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
      if (date != null) 'date': date.toIso8601String(),
    });

    final response = await dio.post(
      ApiConstants.stressFromImage,
      data: formData,
    );

    return Map<String, dynamic>.from(response.data ?? {});
  }
}
