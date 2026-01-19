import '../repositories/calendar_repository.dart';

class AddNoteUseCase {
  final CalendarRepository repository;

  AddNoteUseCase(this.repository);

  Future<void> call({
    required DateTime date,
    required String content,
  }) {
    return repository.addNote(
      date: date,
      content: content,
    );
  }
}
