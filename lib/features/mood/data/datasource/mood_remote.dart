import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:them/core/constants/constants.dart';
import 'package:them/core/resource/data_state.dart';
import 'package:them/features/mood/data/model/mood_model.dart';
import 'package:them/features/mood/domain/entities/mood.dart';

class MoodRemote {

  Future<DataState<List<MoodGetModel>>> getAll(String token, String dateStart, String dateEnd) async {
    final response = await http.get(
        Uri.parse('$URL/mood?start_date=$dateStart&end_date=$dateEnd'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }
    );


      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] is List) {
          final moods = (data['data'] as List)
            .map((item) => MoodGetModel.fromJson(item))
            .toList();
          return DataSuccess(moods);
        }
      }

    return DataFailed('Failed to get data. Status code: ${response.body}');
  }

  Future<DataState<MoodModel>> getDetail(String token, String date) async {
    final response = await http.get(
        Uri.parse('$URL/mood/$date'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }
      );

      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        final model = MoodModel.fromJson(data);
        return DataSuccess(model);
      }

      return DataFailed('Failed to get data. Status code: ${response.body}');
  }

  Future<DataState<String>> update(String token, Mood mood) async {
    final response = await http.post(
        Uri.parse('$URL/mood/update'),
        headers: {
          // 'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          'mood' : mood.mood,
          'note' : mood.note,
          'date' : mood.date
        }
      );

      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        final model = data['message'];
        return DataSuccess(model.toString());
      }

      return DataFailed('Failed to post data. Status code: ${response.body}');
  }

}