import 'package:them/core/resource/data_state.dart';
import 'package:them/core/usecase/usecase.dart';
import 'package:them/features/mood/domain/entities/mood.dart';
import 'package:them/features/mood/domain/repositories/mood_repository.dart';

class UpdateMood implements UseCase<DataState<String>, Mood> {
  final MoodRepository _moodRepository;
  const UpdateMood(this._moodRepository);
  
  @override
  Future<DataState<String>> call({Mood? params}) async {
    return await _moodRepository.update(params!);
  }
  
}