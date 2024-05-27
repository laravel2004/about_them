import 'package:shared_preferences/shared_preferences.dart';
import 'package:them/core/resource/data_state.dart';
import 'package:them/features/consulting/data/datasource/consulting_remote.dart';
import 'package:them/features/consulting/domain/entities/consulting.dart';
import 'package:them/features/consulting/domain/repositories/consulting_repository.dart';

class ConsultingRepositoryImpl implements ConsultingRepository {

  final ConsultingRemote _consultingRemote;

  const ConsultingRepositoryImpl(this._consultingRemote);

  @override
  Future<DataState<ConsultingDetail>> detailConsulting(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if(token != null) {
      final DataState<ConsultingDetail> data = await _consultingRemote.detailConsult(token!, id);
      if(data is DataSuccess) {
        return DataSuccess(data.data!);
      }
      else if(data is DataFailed) {
        return DataFailed(data.error!);
      }
    }
    return const  DataFailed('Unauthorize');
  }

  @override
  Future<DataState<List<ConsultingStatus>>> getAllConsulting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try{
      if(token != null) {
        final DataState<List<ConsultingStatus>> data = await _consultingRemote.getAll(token);
        if(data is DataSuccess) {
          return DataSuccess(data.data!);
        }
        else if(data is DataFailed) {
          return DataFailed(data.error!);
        }
      }

      return const DataFailed('Unautorize');
    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<String>> request(ConsultingRequest req) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try{
      if(token != null) {
        final DataState<String> data = await _consultingRemote.request(token, req);
        if(data is DataSuccess) {
          return DataSuccess(data.data!);
        }
        else if(data is DataFailed) {
          return DataFailed(data.error!);
        }
      }

      return const DataFailed('Unauthorize');
    }
    catch(e) {
      return DataFailed(e.toString());
    } 
  }

}