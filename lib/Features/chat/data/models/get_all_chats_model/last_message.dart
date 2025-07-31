import 'sender.dart';

class LastMessage {
  int? id;
  String? messageType;
  dynamic text;
  dynamic voiceUrl;
  Sender? sender;
  DateTime? createdAt;
  bool? isFromMe;

  LastMessage({
    this.id,
    this.messageType,
    this.text,
    this.voiceUrl,
    this.sender,
    this.createdAt,
    this.isFromMe,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    id: json['id'] as int?,
    messageType: json['messageType'] as String?,
    text: json['text'] as dynamic,
    voiceUrl: json['voiceUrl'] as dynamic,
    sender: json['sender'] == null
        ? null
        : Sender.fromJson(json['sender'] as Map<String, dynamic>),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    isFromMe: json['isFromMe'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'messageType': messageType,
    'text': text,
    'voiceUrl': voiceUrl,
    'sender': sender?.toJson(),
    'createdAt': createdAt?.toIso8601String(),
    'isFromMe': isFromMe,
  };
}
