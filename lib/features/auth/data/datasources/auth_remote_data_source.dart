

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  });

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String gender,
    required int age,
    required String occupation,
  });

  Future<Map<String, dynamic>> getProfile();

  /// Add this so repository can call remote.logout()
  Future<void> logout();
}