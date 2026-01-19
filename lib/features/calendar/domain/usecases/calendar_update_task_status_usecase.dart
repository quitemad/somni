import '../repositories/calendar_repository.dart';

class UpdateTaskStatusUseCase {
  final CalendarRepository repository;

  UpdateTaskStatusUseCase(this.repository);

  Future<void> call({
    required int taskId,
    required bool isCompleted,
  }) {
    return repository.updateTaskStatus(
      taskId: taskId,
      isCompleted: isCompleted,
    );
  }
}
