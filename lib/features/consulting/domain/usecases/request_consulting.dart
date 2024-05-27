import 'package:them/core/resource/data_state.dart';
import 'package:them/core/usecase/usecase.dart';
import 'package:them/features/consulting/domain/entities/consulting.dart';
import 'package:them/features/consulting/domain/repositories/consulting_repository.dart';

class RequestConsulting implements UseCase<DataState<String>, ConsultingRequest> {

  final ConsultingRepository _consultingRepository;

  const RequestConsulting(this._consultingRepository);

  @override
  Future<DataState<String>> call({ConsultingRequest? params}) async {
    return await _consultingRepository.request(params!);
  }

}