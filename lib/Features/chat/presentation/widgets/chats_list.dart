import 'package:flutter/material.dart';
import 'package:vibe_zo/Features/chat/presentation/widgets/custom_chat_item.dart';
import 'package:vibe_zo/core/utils/constants.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.delayed(const Duration(seconds: 1)),
      color: kPrimaryColor,
      backgroundColor: Colors.white,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return CustomChatItem(isPinnedChat: index < 4 ? true : false);
        },
      ),
    );
  }
}
