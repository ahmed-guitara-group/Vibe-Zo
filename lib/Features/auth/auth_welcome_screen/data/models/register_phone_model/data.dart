import 'token.dart';

class Data {
  Token? token;

  Data({this.token});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json['token'] == null
        ? null
        : Token.fromJson(json['token'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {'token': token?.toJson()};
}
