import 'package:them/core/resource/data_state.dart';
import 'package:them/core/usecase/usecase.dart';
import 'package:them/features/auth/domain/entities/user_register.dart';
import 'package:them/features/auth/domain/repositories/auth_repository.dart';

class Login implements UseCase<DataState<String>, UserLogin> {

  final AuthRepository _authRepository;
  const Login(this._authRepository);

  @override
  Future<DataState<String>> call({UserLogin? params}) async {
    return await _authRepository.login(params!);
  }

} 