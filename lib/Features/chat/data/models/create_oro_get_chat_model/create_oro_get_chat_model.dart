import 'chat.dart';

class CreateOrGetChatModel {
  bool? status;
  String? code;
  String? message;
  Chat? chat;

  CreateOrGetChatModel({this.status, this.code, this.message, this.chat});

  factory CreateOrGetChatModel.fromJson(Map<String, dynamic> json) {
    return CreateOrGetChatModel(
      status: json['status'] as bool?,
      code: json['code'] as String?,
      message: json['message'] as String?,
      chat: json['chat'] == null
          ? null
          : Chat.fromJson(json['chat'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'code': code,
    'message': message,
    'chat': chat?.toJson(),
  };
}
