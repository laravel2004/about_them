import 'package:them/core/resource/data_state.dart';
import 'package:them/features/mood/domain/entities/mood.dart';

abstract class MoodRepository {
  Future<DataState<List<MoodlGet>>> getAll(DateMoodQuery query);
  Future<DataState<Mood>> getDetail(String date);
  Future<DataState<String>> update(Mood mood); 
}