import 'data.dart';

class GetAllChatsModel {
  bool? status;
  String? code;
  String? message;
  AllChatsData? data;

  GetAllChatsModel({this.status, this.code, this.message, this.data});

  factory GetAllChatsModel.fromJson(Map<String, dynamic> json) {
    return GetAllChatsModel(
      status: json['status'] as bool?,
      code: json['code'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : AllChatsData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'code': code,
    'message': message,
    'data': data?.toJson(),
  };
}
