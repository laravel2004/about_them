import 'package:them/core/resource/data_state.dart';
import 'package:them/core/usecase/usecase.dart';
import 'package:them/features/journal/domain/entities/journal.dart';
import 'package:them/features/journal/domain/repositories/journal_repository.dart';

class CreateJournal implements UseCase<DataState<String>, JournalCreate> {

  final JournalRepository _journalRepository;

  const CreateJournal(this._journalRepository);

  @override
  Future<DataState<String>> call({JournalCreate? params}) async {
    return await _journalRepository.create(params!);
  }

}