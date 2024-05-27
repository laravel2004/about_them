import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:them/core/constants/constants.dart';
import 'package:them/core/resource/data_state.dart';
import 'package:them/features/mood/data/model/mood_model.dart';
import 'package:them/features/mood/domain/entities/mood.dart';

class MoodRemote {

  Future<DataState<List<MoodGetModel>>> getAll(String token, String dateStart, String dateEnd) async {
    try{
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
        final model = MoodGetModel.fromJson(data);
        return DataSuccess(model as List<MoodGetModel>);
      }

      return DataFailed('Failed to get data. Status code: ${response.statusCode}');

    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<MoodGetModel>> getDetail(String token, String date) async {
    try{
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
        final model = MoodGetModel.fromJson(data);
        return DataSuccess(model);
      }

      return DataFailed('Failed to get data. Status code: ${response.statusCode}');

    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<String>> update(String token, Mood mood) async {
    try{
      final response = await http.put(
        Uri.parse('$URL/mood/update'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: MoodModel.fromEntity(mood)
      );

      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        final model = data['message'];
        return DataSuccess(model.toString());
      }

      return DataFailed('Failed to get data. Status code: ${response.statusCode}');

    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

}