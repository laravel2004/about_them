import 'package:them/core/resource/data_state.dart';
import 'package:them/core/usecase/usecase.dart';
import 'package:them/features/auth/domain/entities/user.dart';
import 'package:them/features/auth/domain/repositories/auth_repository.dart';

class Me implements UseCase<DataState<User>, String> {

  final AuthRepository _authRepository;

  const Me(this._authRepository);

  @override
  Future<DataState<User>> call({String? params}) async {
    return await _authRepository.me(params!);
  }

}