
import '../../domain/repositories/chatbot_repository.dart';
import '../../domain/entities/chat_entites.dart';
import 'chatbot_remote_datasource.dart';

class ChatbotRepositoryImpl implements ChatbotRepository {
  final ChatbotRemoteDataSource remote;

  ChatbotRepositoryImpl(this.remote);

  @override
  Future<StartSessionResult> startSession() async {
    final raw = await remote.startSession();

    final nodeRaw = raw['node'] as Map<String, dynamic>?;

    ChatNodeEntity? node;

    if (nodeRaw != null) {
      node = ChatNodeEntity(
        id: nodeRaw['id']?.toString() ?? '',
        type: nodeRaw['type']?.toString() ?? 'question',
        text: nodeRaw['text']?.toString() ?? '',
        answers: (nodeRaw['answers'] as List<dynamic>? ?? [])
            .map(
              (a) => ChatAnswerEntity(
            value: a['value'].toString(),
            label: a['label'].toString(),
          ),
        )
            .toList(),
      );
    }

    return StartSessionResult(
      sessionId: raw['session_id']?.toString(),
      node: node,
    );
  }

  @override
  Future<Map<String, dynamic>> submitAnswer({
    required String sessionId,
    required String nodeId,
    required dynamic answer,
  }) async{
    var response = await remote.submitAnswer(
      sessionId: sessionId,
      nodeId: nodeId,
      answer: answer,
    );

    return response;
  }

  @override
  Future<Map<String, dynamic>> getSession(String sessionId) async {
    return remote.getSession(sessionId);
  }
}
