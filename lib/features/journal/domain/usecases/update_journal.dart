import 'package:them/core/resource/data_state.dart';
import 'package:them/core/usecase/usecase.dart';
import 'package:them/features/journal/domain/entities/journal.dart';
import 'package:them/features/journal/domain/repositories/journal_repository.dart';

class UpdateJournal implements UseCase<DataState<String>, JournalCreate> {

  final JournalRepository _journalRepository;

  const UpdateJournal(this._journalRepository);

  @override
  Future<DataState<String>> call({JournalCreate? params}) async {
    return await _journalRepository.update(params!);
  }

}