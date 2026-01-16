// // features/auth/data/datasources/auth_remote_data_source_impl.dart
//
// import 'package:dio/dio.dart';
// import '../../../../core/network/api_constants.dart';
// import 'auth_remote_data_source.dart';
//
// class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
//   final Dio dio;
//
//   AuthRemoteDataSourceImpl(this.dio);
//
//   @override
//   Future<Map<String, dynamic>> login({
//     required String email,
//     required String password,
//   }) async {
//     final response = await dio.post(
//       ApiConstants.login,
//       data: {
//         'email': email,
//         'password': password,
//       },
//     );
//
//     return response.data;
//   }
//
//   @override
//   Future<Map<String, dynamic>> register({
//     required String name,
//     required String email,
//     required String password,
//     required String passwordConfirmation,
//     required String gender,
//     required int age,
//     required String occupation,
//   }) async {
//     final response = await dio.post(
//       ApiConstants.register,
//       data: {
//         'name': name,
//         'email': email,
//         'password': password,
//         'password_confirmation': passwordConfirmation,
//         'gender': gender,
//         'age': age,
//         'occupation': occupation,
//       },
//     );
//
//     return response.data;
//   }
//
//   @override
//   Future<Map<String, dynamic>> getProfile() async {
//     final response = await dio.get(ApiConstants.me);
//     return response.data;
//   }
// }
// features/auth/data/datasources/auth_remote_data_source_impl.dart

import 'package:dio/dio.dart';
import '../../../../core/network/api_constants.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      ApiConstants.login,
      data: {'email': email, 'password': password},
    );
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String gender,
    required int age,
    required String occupation,
  }) async {
    final response = await dio.post(
      ApiConstants.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'gender': gender,
        'age': age,
        'occupation': occupation,
      },
    );
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> getProfile() async {
    final response = await dio.get(ApiConstants.me);
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<void> logout() async {
    await dio.post(ApiConstants.logout);
  }
}