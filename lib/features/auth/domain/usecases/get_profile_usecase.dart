import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

class GetProfileUseCase {
  final AuthRepository repository;
  GetProfileUseCase(this.repository);

  Future<User> call() {
    return repository.getProfile();
  }
}
