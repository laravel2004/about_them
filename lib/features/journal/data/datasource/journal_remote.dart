import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:them/core/constants/constants.dart';
import 'package:them/core/resource/data_state.dart';
import 'package:them/features/journal/data/model/journal_model.dart';
import 'package:them/features/journal/domain/entities/journal.dart';

class JournalRemote {

  Future<DataState<List<JournalAllModel>>> getAll(String token) async {
    try{
      final response = await http.get(
        Uri.parse('$URL/note'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }, 
      );

      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        final model = JournalAllModel.fromJson(data);
        return DataSuccess(model as List<JournalAllModel>);
      }
      else {
        return DataFailed('Failed to get data. Status code: ${response.statusCode}');
      }

    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<JournalDetailModel>> getDetail(String token, int id) async {
    try{
      final response = await http.get(
        Uri.parse('$URL/note/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        final model = JournalDetailModel.fromJson(data);
        return DataSuccess(model);
      }
      else {
        return DataFailed('Failed to get data. Status code: ${response.statusCode}');
      }

    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<String>> create(String token, JournalCreate journal ) async {
    try{
      final response = await http.post(
        Uri.parse('$URL/note/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "title" : journal.title,
          "note" : journal.note
        })
      );

      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        final model = data['messsage'].toString();
        return DataSuccess(model);
      }
      else {
        return DataFailed('Failed to post data. Status code: ${response.statusCode}');
      }
    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<String>> update(JournalCreate journal, String token) async {
    try{
      final response = await http.patch(
        Uri.parse('$URL/note/update/${journal.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'title' : journal.title,
          'note' : journal.note,
          'id' : journal.id
        })
      );

      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        final model = data['message'];
        return DataSuccess(model);
      }
      else {
        return DataFailed('Failed to update data. Status code: ${response.statusCode}');
      }
    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<String>> delete(int id, String token) async {
    try{
      final response = await http.delete(
        Uri.parse('$URL/note/delete/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if(response.statusCode == 200) {
        final data = json.decode(response.body);
        final model = data['message'].toString();
        return DataSuccess(model);
      }
      else {
        return DataFailed('Failed to delete data. Status code: ${response.statusCode}');
      }
    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

}