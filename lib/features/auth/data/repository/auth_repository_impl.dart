import 'package:them/core/resource/data_state.dart';
import 'package:them/features/auth/data/datasource/auth_remote.dart';
import 'package:them/features/auth/data/model/token.dart';
import 'package:them/features/auth/domain/entities/user.dart';
import 'package:them/features/auth/domain/entities/user_register.dart';
import 'package:them/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthRemote _authRemote;

  const AuthRepositoryImpl(this._authRemote);

  @override
  Future<DataState<String>> login(UserLogin user) async {
    final DataState<TokenModel> result = await _authRemote.login(user);

    if (result is DataSuccess) {
      return DataSuccess(result.data!.token!);
    } else if (result is DataFailed) {
      return DataFailed(result.error!);
    } else {
      return const DataFailed("Unknown error");
    }
  }

  @override
  Future<DataState<User>> me(String token) async {
    final DataState<User> result = await _authRemote.me(token);

    if(result is DataSuccess) {
      return DataSuccess(result.data!);
    }
    else if(result is DataFailed) {
      return DataFailed(result.error!);
    }
    else {
      return const DataFailed("Unknown error");
    }
  }

  @override
  Future<DataState<User>> register(UserRegister user) async {
    final DataState<User> result = await _authRemote.register(user);

    if(result is DataSuccess) {
      return DataSuccess(result.data!);
    }
    else if(result is DataFailed) {
      return DataFailed(result.error!);
    }
    else {
      return const DataFailed("Unknown error");
    }
  }

}