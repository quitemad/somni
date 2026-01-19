

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:somni/core/network/api_constants.dart';

/// Only responsible for network calls. Returns raw Map<String, dynamic>.
class ChatbotRemoteDataSource {
  final Dio dio;
  ChatbotRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> startSession({Map<String, dynamic>? payload}) async {
    final res = await dio.post(ApiConstants.chatbotSessionStart, data: payload ?? {});
    return Map<String, dynamic>.from(res.data ?? {});
  }

  Future<Map<String, dynamic>> submitAnswer({
    required String sessionId,
    required String nodeId,
    required dynamic answer,
  }) async {
    final res = await dio.post(ApiConstants.chatbotSessionAnswer, data: {
      'session_id': sessionId,
      'node_id': nodeId,
      'answer': answer,
    });
    Logger().w("${ Map<String, dynamic>.from(res.data ?? {})}");
    return Map<String, dynamic>.from(res.data ?? {});
  }

  Future<Map<String, dynamic>> getSession(String sessionId) async {
    final res = await dio.get('${ApiConstants.chatbotSession}$sessionId');
    return Map<String, dynamic>.from(res.data ?? {});
  }
}
