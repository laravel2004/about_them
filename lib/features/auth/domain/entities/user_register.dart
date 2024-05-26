import 'package:equatable/equatable.dart';

class UserRegister extends Equatable {
  final String? name;
  final String? email;
  final String? password;
  final String? role;


  const UserRegister({
    this.email,
    this.name,
    this.password,
    this.role
  });
  @override
  List<Object?> get props => [name!, email!, password!, role!];
}

class UserLogin extends Equatable {
  final String? email;
  final String? password;


  const UserLogin({
    this.email,
    this.password,
  });
  @override
  List<Object?> get props => [email!, password!];
}
