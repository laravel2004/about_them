import 'package:shared_preferences/shared_preferences.dart';
import 'package:them/core/resource/data_state.dart';
import 'package:them/features/journal/data/datasource/journal_remote.dart';
import 'package:them/features/journal/domain/entities/journal.dart';
import 'package:them/features/journal/domain/repositories/journal_repository.dart';

class JournalRepositoryImpl implements JournalRepository {

  final JournalRemote _journalRemote;

  const JournalRepositoryImpl(this._journalRemote);

  @override
  Future<DataState<String>> create(JournalCreate journal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try{
      if(token != null) {
        final DataState<String> data = await _journalRemote.create(token, journal);
        if(data is DataSuccess) {
          return DataSuccess(data.data!);
        }
        else {
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
  Future<DataState<String>> delete(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      if(token != null) {
        final DataState<String> data = await _journalRemote.delete(id, token);
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
  Future<DataState<List<JournalAll>>> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try{
      if(token != null) {
        final DataState<List<JournalAll>> data = await _journalRemote.getAll(token);
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
  Future<DataState<JournalDetail>> getDetail(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try{
      if(token != null) {
        final DataState<JournalDetail> data = await _journalRemote.getDetail(token, id);
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
  Future<DataState<String>> update(JournalCreate journal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token =  prefs.getString('title');

    if(token != null) {
      final DataState<String> data = await _journalRemote.update(journal, token);
      if(data is DataSuccess) {
        return DataSuccess(data.data!);
      }
      else {
        return DataFailed(data.error!);
      }
    }
    return const DataFailed("Unauthorize");
  }

}