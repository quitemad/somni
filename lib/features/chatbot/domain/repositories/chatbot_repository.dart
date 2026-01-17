import '../entities/chat_entites.dart';

abstract class ChatbotRepository {
  Future<StartSessionResult> startSession();
  Future<Map<String, dynamic>> submitAnswer({
    required String sessionId,
    required String nodeId,
    required dynamic answer,
  });
  Future<Map<String, dynamic>> getSession(String sessionId);
}