import '../../domain/entities/notes_entity.dart';

class NoteModel {
  final int id;
  final String date;
  final String content;

  NoteModel({
    required this.id,
    required this.date,
    required this.content,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      date: json['date'],
      content: json['content'],
    );
  }

  Note toEntity() {
    return Note(
      id: id,
      date: DateTime.parse(date),
      content: content,
    );
  }
}
