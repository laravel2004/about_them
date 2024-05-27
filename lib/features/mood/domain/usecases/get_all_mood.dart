import 'package:them/core/resource/data_state.dart';
import 'package:them/core/usecase/usecase.dart';
import 'package:them/features/mood/domain/entities/mood.dart';
import 'package:them/features/mood/domain/repositories/mood_repository.dart';

class GetAllMood implements UseCase<DataState<List<MoodlGet>>, DateMoodQuery> {

  final MoodRepository _moodRepository;

  const GetAllMood(this._moodRepository);
  
  @override
  Future<DataState<List<MoodlGet>>> call({DateMoodQuery? params}) async {
    return await _moodRepository.getAll(params!);
  }
  
}