// ignore_for_file: non_constant_identifier_names

import 'package:them/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    super.id,
    super.name,
    super.email,
    super.email_verified_at,
    super.role,
    super.created_at,
    super.updated_at,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['data']['id'] ?? '',
      created_at: json['data']['created_at'] ?? '',
      email: json['data']['email'] ?? '',
      email_verified_at: json['data']['email_verified_at'] ?? '',
      name: json['data']['name'] ?? '',
      role: json['data']['role'] ?? '',
      updated_at: json['data']['updated_at'] ?? ''
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      created_at: user.created_at,
      email: user.email,
      email_verified_at: user.email_verified_at,
      id: user.id,
      name: user.name,
      role: user.role,
      updated_at: user.updated_at
    );
  }
}