import '../../domain/entities/chat_entites.dart';
import '../../domain/repositories/chatbot_repository.dart' as domain_repo;
import '../datasources/chatbot_remote_datasource.dart';
import '../model/chatbot_model.dart';

class ChatbotRepositoryImpl implements domain_repo.ChatbotRepository {
  final ChatbotRemoteDataSource remote;
  ChatbotRepositoryImpl(this.remote);

  @override
  Future<StartSessionResult> startSession() async {
    final raw = await remote.startSession();
    final sessionId = raw['session_id']?.toString();
    final nodeRaw = raw['node'] as Map<String, dynamic>?;
    ChatNodeEntity? node;
    if (nodeRaw != null) {
      final m = ChatNodeModel.fromMap(nodeRaw);
      node = ChatNodeEntity(
        id: m.id,
        type: m.type,
        text: m.text,
        answers: m.answers.map((a) => ChatAnswerEntity(value: a.value, label: a.label)).toList(),
      );
    }
    return StartSessionResult(sessionId: sessionId, node: node);
  }

  @override
  Future<Map<String, dynamic>> submitAnswer({
    required String sessionId,
    required String nodeId,
    required dynamic answer,
  }) async {
    final raw = await remote.submitAnswer(sessionId: sessionId, nodeId: nodeId, answer: answer);
    return raw;
  }

  @override
  Future<Map<String, dynamic>> getSession(String sessionId) async {
    final raw = await remote.getSession(sessionId);
    return raw;
  }
}