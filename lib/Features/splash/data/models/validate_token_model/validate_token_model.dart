import 'user.dart';

class ValidateTokenModel {
  bool? status;
  String? code;
  String? message;
  User? user;

  ValidateTokenModel({this.status, this.code, this.message, this.user});

  factory ValidateTokenModel.fromJson(Map<String, dynamic> json) {
    return ValidateTokenModel(
      status: json['status'] as bool?,
      code: json['code'] as String?,
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'code': code,
    'message': message,
    'user': user?.toJson(),
  };
}
