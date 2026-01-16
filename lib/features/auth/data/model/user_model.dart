// features/auth/data/models/user_model.dart

class UserModel {
  final int id;
  final String name;
  final String email;
  final String gender;
  final int age;
  final String occupation;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.age,
    required this.occupation,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      age: json['age'],
      occupation: json['occupation'],
    );
  }
}
