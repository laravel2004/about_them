import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:them/core/constants/constants.dart';
import 'package:them/core/resource/data_state.dart';
import 'package:them/features/consulting/data/model/consulting_model.dart';
import 'package:them/features/consulting/domain/entities/consulting.dart';

class ConsultingRemote {

  Future<DataState<List<ConsultingStatusModel>>> getAll(String token) async {
    try{
      final response = await http.get(
        Uri.parse('$URL/konseling'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        final model = ConsultingStatusModel.fromJson(data);
        return DataSuccess(model as List<ConsultingStatusModel>);
      }
      else {
        return DataFailed("Failed to get data. Status code: ${response.statusCode}");
      }
    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<ConsultingDetailModel>> detailConsult(String token, int id) async {
    try{
      final response = await http.get(
        Uri.parse('$URL/konseling/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        final result = ConsultingDetailModel.fromJson(data);
        return DataSuccess(result);
      }
      else {
        return DataFailed("Failed to get data. Status code: ${response.statusCode}");
      }
    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<String>> request(String token, ConsultingRequest consult) async {
    try{
      final response = await http.post(
        Uri.parse('$URL/konseling/request'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "problem" : consult.problem,

        })
      );

      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        final result = data['message'];
        return DataSuccess(result);
      }
      else {
        return DataFailed("Failed to post data. Status code: ${response.statusCode}");
      }

    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

}