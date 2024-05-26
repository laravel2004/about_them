import 'package:them/core/resource/data_state.dart';
import 'package:them/core/usecase/usecase.dart';
import 'package:them/features/auth/domain/entities/user.dart';
import 'package:them/features/auth/domain/entities/user_register.dart';
import 'package:them/features/auth/domain/repositories/auth_repository.dart';

class Register implements UseCase<DataState<User>, UserRegister> {

  final AuthRepository _authRepository;

  Register(this._authRepository);
  
  @override
  Future<DataState<User>> call({UserRegister? params}) async {
    return await _authRepository.register(params!);
  }

  
}