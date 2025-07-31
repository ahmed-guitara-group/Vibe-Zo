import 'message.dart';

class SendMessageModel {
  bool? status;
  String? code;
  Message? message;

  SendMessageModel({this.status, this.code, this.message});

  factory SendMessageModel.fromJson(Map<String, dynamic> json) {
    return SendMessageModel(
      status: json['status'] as bool?,
      code: json['code'] as String?,
      message: json['message'] == null
          ? null
          : Message.fromJson(json['message'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'code': code,
    'message': message?.toJson(),
  };
}
