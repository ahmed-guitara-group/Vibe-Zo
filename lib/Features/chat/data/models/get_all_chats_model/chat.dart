import 'last_message.dart';
import 'other_user.dart';

class Chat {
  int? id;
  bool? isPinned;
  OtherUser? otherUser;
  LastMessage? lastMessage;
  DateTime? createdAt;
  DateTime? lastMessageAt;

  Chat({
    this.id,
    this.isPinned,
    this.otherUser,
    this.lastMessage,
    this.createdAt,
    this.lastMessageAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json['id'] as int?,
    isPinned: json['isPinned'] as bool?,
    otherUser: json['otherUser'] == null
        ? null
        : OtherUser.fromJson(json['otherUser'] as Map<String, dynamic>),
    lastMessage: json['lastMessage'] == null
        ? null
        : LastMessage.fromJson(json['lastMessage'] as Map<String, dynamic>),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    lastMessageAt: json['lastMessageAt'] == null
        ? null
        : DateTime.parse(json['lastMessageAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'isPinned': isPinned,
    'otherUser': otherUser?.toJson(),
    'lastMessage': lastMessage?.toJson(),
    'createdAt': createdAt?.toIso8601String(),
    'lastMessageAt': lastMessageAt?.toIso8601String(),
  };
}
