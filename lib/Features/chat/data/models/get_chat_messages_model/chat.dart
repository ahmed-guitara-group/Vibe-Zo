import 'message.dart';
import 'other_user.dart';
import 'pagination.dart';

class Chat {
  int? id;
  OtherUser? otherUser;
  List<Message>? messages;
  Pagination? pagination;
  DateTime? createdAt;

  Chat({
    this.id,
    this.otherUser,
    this.messages,
    this.pagination,
    this.createdAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json['id'] as int?,
    otherUser: json['otherUser'] == null
        ? null
        : OtherUser.fromJson(json['otherUser'] as Map<String, dynamic>),
    messages: (json['messages'] as List<dynamic>?)
        ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
        .toList(),
    pagination: json['pagination'] == null
        ? null
        : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'otherUser': otherUser?.toJson(),
    'messages': messages?.map((e) => e.toJson()).toList(),
    'pagination': pagination?.toJson(),
    'createdAt': createdAt?.toIso8601String(),
  };
}
