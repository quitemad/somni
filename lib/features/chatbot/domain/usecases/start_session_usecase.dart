import '../entities/chat_entites.dart';
import '../repositories/chatbot_repository.dart';

class StartSessionUseCase {
  final ChatbotRepository repository;
  StartSessionUseCase(this.repository);

  Future<StartSessionResult> call() async {
    return repository.startSession();
  }
}