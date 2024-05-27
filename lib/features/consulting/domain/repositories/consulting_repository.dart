import 'package:them/core/resource/data_state.dart';
import 'package:them/features/consulting/domain/entities/consulting.dart';

abstract class ConsultingRepository {
  Future<DataState<String>> request(ConsultingRequest req);
  Future<DataState<ConsultingDetail>> detailConsulting(int id);
  Future<DataState<List<ConsultingStatus>>> getAllConsulting();
}