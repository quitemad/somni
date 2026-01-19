import 'package:somni/features/auth/data/model/user_model.dart';

import '../repository/auth_repository.dart';

class GetProfileUseCase {
  final AuthRepository repository;
  GetProfileUseCase(this.repository);

  Future<UserModel> call() {
    return repository.getProfile();
  }
}
