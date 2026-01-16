import '../../domain/entities/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../model/user_model.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/storage/token_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final DioClient dioClient;
  final TokenStorage tokenStorage;

  AuthRepositoryImpl(this.remote, this.dioClient, this.tokenStorage);

  @override
  Future<User> login(String email, String password) async {
    final data = await remote.login(email: email, password: password);

    final token = data['token'] as String?;
    if (token != null) {
      dioClient.setToken(token);
      await tokenStorage.saveToken(token); // persist token
    }

    final model = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    return User(id: model.id, name: model.name, email: model.email);
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String gender,
    required int age,
    required String occupation,
  }) async {
    final data = await remote.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      gender: gender,
      age: age,
      occupation: occupation,
    );

    final token = data['token'] as String?;
    if (token != null) {
      dioClient.setToken(token);
      await tokenStorage.saveToken(token);
    }

    final model = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    return User(id: model.id, name: model.name, email: model.email);
  }

  @override
  Future<User> getProfile() async {
    final data = await remote.getProfile();
    final model = UserModel.fromJson(data['user'] as Map<String, dynamic>);
    return User(id: model.id, name: model.name, email: model.email);
  }

  @override
  Future<void> logout() async {
    try {
      await remote.logout();
    } catch (_) {
      // ignore remote errors
    }
    await tokenStorage.clear();
    dioClient.clearToken();
  }
}