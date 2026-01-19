import 'package:dio/dio.dart';
import 'package:somni/core/network/api_constants.dart';

import '../model/music_prediction_model.dart';
import 'music_remote_datasource.dart';

class MusicRemoteDataSourceImpl implements MusicRemoteDataSource {
  final Dio dio;

  MusicRemoteDataSourceImpl(this.dio);

  @override
  Future<MusicPredictionModel> predict(String query) async {
    final response = await dio.post(
      ApiConstants.musicPrediction,
      data: {'query': query},
    );

    return MusicPredictionModel.fromJson(response.data);
  }
}
