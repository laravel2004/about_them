import 'package:them/core/resource/data_state.dart';
import 'package:them/core/usecase/usecase.dart';
import 'package:them/features/journal/domain/repositories/journal_repository.dart';

class DeleteJournal implements UseCase<DataState<String>, int> {

  final JournalRepository _journalRepository;
  const DeleteJournal(this._journalRepository);

  @override
  Future<DataState<String>> call({int? params}) async {
    return await _journalRepository.delete(params!);
  }
  
}