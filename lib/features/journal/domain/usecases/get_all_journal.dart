import 'package:them/core/resource/data_state.dart';
import 'package:them/core/usecase/usecase.dart';
import 'package:them/features/journal/domain/entities/journal.dart';
import 'package:them/features/journal/domain/repositories/journal_repository.dart';

class GetAllJournal implements UseCase<DataState<List<JournalAll>>,void>{

  final JournalRepository _journalRepository;

  const GetAllJournal(this._journalRepository);

  @override
  Future<DataState<List<JournalAll>>> call({void params}) async {
    return await _journalRepository.getAll();
  }

} 