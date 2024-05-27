import 'package:them/core/resource/data_state.dart';
import 'package:them/core/usecase/usecase.dart';
import 'package:them/features/mood/domain/entities/mood.dart';
import 'package:them/features/mood/domain/repositories/mood_repository.dart';

class GetDetailMood implements UseCase<DataState<Mood>, String> {
  final MoodRepository _moodRepository;
  GetDetailMood(this._moodRepository);
  
  @override
  Future<DataState<Mood>> call({String? params}) async {
    return await _moodRepository.getDetail(params!);
  }
}