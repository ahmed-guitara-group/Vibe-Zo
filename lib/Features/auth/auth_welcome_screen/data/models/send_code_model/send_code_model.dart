class SendCodeModel {
  bool? status;
  String? code;
  String? message;

  SendCodeModel({this.status, this.code, this.message});

  factory SendCodeModel.fromJson(Map<String, dynamic> json) => SendCodeModel(
    status: json['status'] as bool?,
    code: json['code'] as String?,
    message: json['message'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'code': code,
    'message': message,
  };
}
