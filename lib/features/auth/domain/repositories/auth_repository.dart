import 'package:them/core/resource/data_state.dart';
import 'package:them/features/auth/domain/entities/user.dart';
import 'package:them/features/auth/domain/entities/user_register.dart';

abstract class AuthRepository {
  Future<DataState<User>> register(UserRegister user);
  Future<DataState<String>> login(UserLogin user);
  Future <DataState<User>> me(String token);
}