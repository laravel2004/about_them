import 'package:equatable/equatable.dart';

class TokenModel extends Equatable {
  final String? token;

  const TokenModel({this.token});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(token: json['data']['token']);
  }

  Map<String, dynamic> toJson() {
    return {'token': token};
  }

  @override
  List<Object> get props => [token!];
}
