import 'data.dart';

class SetupProfileModel {
  bool? status;
  String? code;
  String? message;
  Data? data;

  SetupProfileModel({this.status, this.code, this.message, this.data});

  factory SetupProfileModel.fromJson(Map<String, dynamic> json) {
    return SetupProfileModel(
      status: json['status'] as bool?,
      code: json['code'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'code': code,
    'message': message,
    'data': data?.toJson(),
  };
}
