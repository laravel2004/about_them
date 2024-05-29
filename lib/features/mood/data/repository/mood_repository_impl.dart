import 'package:shared_preferences/shared_preferences.dart';
import 'package:them/core/resource/data_state.dart';
import 'package:them/features/mood/data/datasource/mood_remote.dart';
import 'package:them/features/mood/domain/entities/mood.dart';
import 'package:them/features/mood/domain/repositories/mood_repository.dart';

class MoodRepositoryImpl implements MoodRepository {

  final MoodRemote _moodRemote;

  const MoodRepositoryImpl(this._moodRemote);

  @override
  Future<DataState<List<MoodlGet>>> getAll(DateMoodQuery query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try{
      if(token != null) {
        final DataState<List<MoodlGet>> data = await _moodRemote.getAll(token, query.dateStart, query.dateEnd);
        if(data is DataSuccess) {
          return DataSuccess(data.data!);
        }
        else {
          return DataFailed(data.error!);
        }
      }
      return const DataFailed("Unauthorize");
    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<Mood>> getDetail(String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try{
      if(token != null) {
        final DataState<Mood> data = (await _moodRemote.getDetail(token, date)) as DataState<Mood>;
        if(data is DataSuccess) {
          return DataSuccess(data.data!);
        }
        else {
          return DataFailed(data.error!);
        }
      }
      return const DataFailed("Unauthorize");
    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<String>> update(Mood mood) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try{
      if(token != null) {
        final DataState<String> data = await _moodRemote.update(token, mood);
        if(data is DataSuccess) {
          return DataSuccess(data.data!);
        }
        else {
          return DataFailed(data.error!);
        }
      }
      return const DataFailed("Unauthorize");
    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

}