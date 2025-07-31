import 'sender.dart';

class Message {
  int? id;
  String? messageType;
  dynamic text;
  dynamic voiceUrl;
  dynamic giftTransaction;
  Sender? sender;
  dynamic receiver;
  DateTime? createdAt;
  bool? isFromMe;

  Message({
    this.id,
    this.messageType,
    this.text,
    this.voiceUrl,
    this.giftTransaction,
    this.sender,
    this.receiver,
    this.createdAt,
    this.isFromMe,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json['id'] as int?,
    messageType: json['messageType'] as String?,
    text: json['text'] as dynamic,
    voiceUrl: json['voiceUrl'] as dynamic,
    giftTransaction: json['giftTransaction'] as dynamic,
    sender: json['sender'] == null
        ? null
        : Sender.fromJson(json['sender'] as Map<String, dynamic>),
    receiver: json['receiver'] as dynamic,
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
    'giftTransaction': giftTransaction,
    'sender': sender?.toJson(),
    'receiver': receiver,
    'createdAt': createdAt?.toIso8601String(),
    'isFromMe': isFromMe,
  };
}
