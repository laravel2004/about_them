// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class User extends Equatable {

  final int? id;
  final String? name;
  final String? email;
  final String? email_verified_at;
  final String? role;
  final String? created_at;
  final String? updated_at;

  const User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.email_verified_at,
    this.created_at,
    this.updated_at,
  });
  

  @override
  List<Object> get props => [id!, name!, email!, role!, email_verified_at!, created_at!, updated_at!];
}