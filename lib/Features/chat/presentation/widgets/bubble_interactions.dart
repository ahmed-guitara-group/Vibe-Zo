import 'package:flutter/material.dart';
import 'package:vibe_zo/Features/chat/presentation/widgets/chat_bubble.dart';
import 'package:vibe_zo/Features/chat/presentation/widgets/reactions_widget.dart';
import 'package:vibe_zo/core/utils/assets.dart';

import 'bubble_interaction_item.dart';

class BubbleInteractions extends StatelessWidget {
  const BubbleInteractions({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ChatBubble(
            message: message,
            isMe: true,
            showAvatar: false,
            onReply: (p0) {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ReactionsWidget(),
          ),
          GestureDetector(
            onTap: () {},
            child: BubbleInteractionItem(
              iconPath: AssetsData.infoIcon,
              title: "Info",
            ),
          ),
          GestureDetector(
            child: BubbleInteractionItem(
              iconPath: AssetsData.replyIcon,
              title: "Reply",
            ),
          ),
          GestureDetector(
            child: BubbleInteractionItem(
              iconPath: AssetsData.copy,
              title: "Copy",
            ),
          ),
          GestureDetector(
            child: BubbleInteractionItem(
              iconPath: AssetsData.reportIcon,
              title: "Report",
            ),
          ),
          GestureDetector(
            child: BubbleInteractionItem(
              iconPath: AssetsData.trash1,
              title: "Delete for me",
            ),
          ),
          GestureDetector(
            child: BubbleInteractionItem(
              iconPath: AssetsData.trash,
              title: "Delete for all",
            ),
          ),
        ],
      ),
    );
  }
}
