import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String gender;
  final int age;
  final String occupation;

  const RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.gender,
    required this.age,
    required this.occupation,
  });

  @override
  List<Object?> get props => [name, email];
}

class ProfileRequested extends AuthEvent {
  const ProfileRequested();
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}