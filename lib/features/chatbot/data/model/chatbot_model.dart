class ChatAnswerModel {
  final String value;
  final String label;
  ChatAnswerModel({required this.value, required this.label});

  factory ChatAnswerModel.fromMap(Map<String, dynamic> map) {
    return ChatAnswerModel(
      value: (map['value'] ?? '').toString(),
      label: (map['label'] ?? map['value'] ?? '').toString(),
    );
  }
}

class ChatNodeModel {
  final String id;
  final String type;
  final String text;
  final List<ChatAnswerModel> answers;

  ChatNodeModel({
    required this.id,
    required this.type,
    required this.text,
    required this.answers,
  });

  factory ChatNodeModel.fromMap(Map<String, dynamic> map) {
    final ans = <ChatAnswerModel>[];
    if (map['answers'] is List) {
      for (final a in (map['answers'] as List)) {
        ans.add(ChatAnswerModel.fromMap(Map<String, dynamic>.from(a)));
      }
    }
    return ChatNodeModel(
      id: (map['id'] ?? '').toString(),
      type: (map['type'] ?? 'question').toString(),
      text: (map['text'] ?? '').toString(),
      answers: ans,
    );
  }
}