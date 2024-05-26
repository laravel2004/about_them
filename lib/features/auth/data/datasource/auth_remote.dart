import 'dart:convert';

import 'package:them/core/constants/constants.dart';
import 'package:them/core/resource/data_state.dart';
import 'package:them/features/auth/data/model/token.dart';
import 'package:them/features/auth/data/model/user.dart';
import 'package:them/features/auth/domain/entities/user_register.dart';
import 'package:http/http.dart' as http;

class AuthRemote {
  Future<DataState<UserModel>> register(UserRegister user) async {
    try{
      final response = await http.post(
        Uri.parse('$URL/register'),
        headers: {'Content-Type': 'application/json'},
        body:  json.encode({
          'name' : user.name,
          'email' : user.email,
          'password' : user.password,
          'role' : user.role
        })
      );

      if(response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final userModel = UserModel.fromJson(responseBody);
        return DataSuccess(userModel);
      }
      else {
        return DataFailed("Failed to register. Status code: ${response.statusCode}");
      }
    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<TokenModel>> login(UserLogin user) async {
    try{
      final response = await http.post(
        Uri.parse('$URL/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "name" : user.email,
          "password" : user.password
        })
      );

      if(response.statusCode == 200) {
        final token = TokenModel.fromJson(json.decode(response.body));
        return DataSuccess(token);
      }
      else {
        return  DataFailed("Failed to login. Status code: ${response.statusCode}");
      }
    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }

  Future<DataState<UserModel>> me (String token) async {
    try{
      final response = await http.get(
        Uri.parse('$URL/me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final userModel = UserModel.fromJson(responseBody);
        return DataSuccess(userModel);
      } else {
        return DataFailed("Failed to fetch user data. Status code: ${response.statusCode}");
      }
    }
    catch(e) {
      return DataFailed(e.toString());
    }
  }
}