import 'package:them/core/resource/data_state.dart';
import 'package:them/core/usecase/usecase.dart';
import 'package:them/features/journal/domain/entities/journal.dart';
import 'package:them/features/journal/domain/repositories/journal_repository.dart';

class GetDetailJournal implements UseCase<DataState<JournalDetail>, int> {

  final JournalRepository _journalRepository;
  const GetDetailJournal(this._journalRepository);

  @override
  Future<DataState<JournalDetail>> call({int? params}) async {
    return await _journalRepository.getDetail(params!);
  }

}