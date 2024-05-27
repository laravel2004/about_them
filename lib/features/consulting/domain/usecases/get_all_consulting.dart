import 'package:them/core/resource/data_state.dart';
import 'package:them/core/usecase/usecase.dart';
import 'package:them/features/consulting/domain/entities/consulting.dart';
import 'package:them/features/consulting/domain/repositories/consulting_repository.dart';

class GetAllConsulting implements UseCase<DataState<List<ConsultingStatus>>, void> {

  final ConsultingRepository _consultingRepository;

  const GetAllConsulting(this._consultingRepository);
  
  @override
  Future<DataState<List<ConsultingStatus>>> call({void params}) async {
    return await _consultingRepository.getAllConsulting();
  }


}