import 'package:them/core/resource/data_state.dart';
import 'package:them/core/usecase/usecase.dart';
import 'package:them/features/consulting/domain/entities/consulting.dart';
import 'package:them/features/consulting/domain/repositories/consulting_repository.dart';

class DetailConsulting implements UseCase<DataState<ConsultingDetail>, int> {

  final ConsultingRepository _consultingRepository;

  const DetailConsulting(this._consultingRepository);

  @override
  Future<DataState<ConsultingDetail>> call({int? params}) async {
    return await _consultingRepository.detailConsulting(params!);
  }

} 