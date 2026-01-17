import '../repositories/chatbot_repository.dart';

class SubmitAnswerUseCase {
  final ChatbotRepository repository;
  SubmitAnswerUseCase(this.repository);

  Future<Map<String, dynamic>> call({required String sessionId, required String nodeId, required dynamic answer}) async {
    return repository.submitAnswer(sessionId: sessionId, nodeId: nodeId, answer: answer);
  }
}