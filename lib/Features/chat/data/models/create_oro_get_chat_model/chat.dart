import 'other_user.dart';

class Chat {
  int? id;
  OtherUser? otherUser;
  dynamic lastMessage;
  int? messagesCount;
  DateTime? createdAt;
  DateTime? lastMessageAt;

  Chat({
    this.id,
    this.otherUser,
    this.lastMessage,
    this.messagesCount,
    this.createdAt,
    this.lastMessageAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json['id'] as int?,
    otherUser: json['otherUser'] == null
        ? null
        : OtherUser.fromJson(json['otherUser'] as Map<String, dynamic>),
    lastMessage: json['lastMessage'] as dynamic,
    messagesCount: json['messagesCount'] as int?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    lastMessageAt: json['lastMessageAt'] == null
        ? null
        : DateTime.parse(json['lastMessageAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'otherUser': otherUser?.toJson(),
    'lastMessage': lastMessage,
    'messagesCount': messagesCount,
    'createdAt': createdAt?.toIso8601String(),
    'lastMessageAt': lastMessageAt?.toIso8601String(),
  };
}
