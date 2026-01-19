import '../../data/model/user_model.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String gender,
    required int age,
    required String occupation,
  });
  Future<UserModel> getProfile();

  Future<void> logout();

}
