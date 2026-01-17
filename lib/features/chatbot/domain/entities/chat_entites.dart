class ChatAnswerEntity {
  final String value;
  final String label;
  ChatAnswerEntity({required this.value, required this.label});
}

class ChatNodeEntity {
  final String id;
  final String type;
  final String text;
  final List<ChatAnswerEntity> answers;
  ChatNodeEntity({required this.id, required this.type, required this.text, required this.answers});
}

class StartSessionResult {
  final String? sessionId;
  final ChatNodeEntity? node;
  StartSessionResult({this.sessionId, this.node});
}