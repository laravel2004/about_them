import 'package:them/core/resource/data_state.dart';
import 'package:them/features/journal/domain/entities/journal.dart';

abstract class JournalRepository {
  Future<DataState<List<JournalAll>>> getAll();
  Future<DataState<JournalDetail>> getDetail(int id);
  Future<DataState<String>> create(JournalCreate journal);
  Future<DataState<String>> update(JournalCreate journal);
  Future<DataState<String>> delete(int id);
}