import 'package:flutter/material.dart';
import 'package:vibe_zo/Features/chat/presentation/widgets/custom_chat_item.dart';

import '../../data/models/get_all_chats_model/get_all_chats_model.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key, required this.allChatsModel});
  final GetAllChatsModel allChatsModel;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allChatsModel.data!.chats!.length,
      itemBuilder: (context, index) {
        return CustomChatItem(
          otherUserID: allChatsModel.data!.chats![index].otherUser!.id!
              .toString(),
          allChatsModel: allChatsModel,
          isPinnedChat: allChatsModel.data!.chats![index].isPinned!,
          index: index,
        );
      },
    );
  }
}
