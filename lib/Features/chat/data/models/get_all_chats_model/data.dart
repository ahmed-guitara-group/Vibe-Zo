import 'chat.dart';
import 'user.dart';

class AllChatsData {
  List<User>? users;
  List<Chat>? chats;

  AllChatsData({this.users, this.chats});

  factory AllChatsData.fromJson(Map<String, dynamic> json) => AllChatsData(
    users: (json['users'] as List<dynamic>?)
        ?.map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    chats: (json['chats'] as List<dynamic>?)
        ?.map((e) => Chat.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'users': users?.map((e) => e.toJson()).toList(),
    'chats': chats?.map((e) => e.toJson()).toList(),
  };
}
