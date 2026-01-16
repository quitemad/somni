// register
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  Future<User> call({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String gender,
    required int age,
    required String occupation,
  }) {
    return repository.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      gender: gender,
      age: age,
      occupation: occupation,
    );
  }
}
