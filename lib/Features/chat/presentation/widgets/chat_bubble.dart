import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vibe_zo/Features/chat/presentation/widgets/bubble_interactions.dart';
import 'package:vibe_zo/core/utils/assets.dart';
import 'package:vibe_zo/core/utils/constants.dart';
import 'package:vibe_zo/core/utils/gaps.dart';
import 'package:vibe_zo/core/utils/helper.dart';

import '../../data/models/get_chat_messages_model/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final bool showAvatar;
  final void Function(Message)? onReply;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.showAvatar,
    this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMe ? const Color(0Xccda5280) : Colors.grey[300];
    final textColor = isMe ? Colors.white : Colors.black87;

    return Dismissible(
      key: ValueKey(message.id),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) async {
        if (onReply != null) {
          onReply!(message);
        }
        return false;
      },
      child: GestureDetector(
        onLongPress: () {
          showDialog(
            barrierColor: Colors.white,
            context: context,
            builder: (context) {
              return BubbleInteractions(message: message);
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMe && showAvatar)
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 16,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?u=${message.id}',
                  ),
                ),
              if (!isMe && showAvatar) Gaps.hGap8,
              Flexible(
                child: Stack(
                  alignment: isMe
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      margin: message.giftTransaction != null
                          ? const EdgeInsets.only(bottom: 10)
                          : const EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: bubbleColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (message.messageType == 'text' &&
                              message.text != null)
                            Text(
                              message.text!,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                height: 1.17,
                              ),
                            ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: isMe
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                            children: [
                              if (isMe)
                                CircleAvatar(
                                  maxRadius: context.screenWidth * 0.02,
                                  backgroundColor: const Color(0X33DA5280),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image.asset(AssetsData.seen),
                                  ),
                                ),
                              Gaps.hGap4,
                              Text(
                                DateFormat('HH:mm').format(message.createdAt!),
                                style: TextStyle(
                                  color: isMe
                                      ? Colors.white.withOpacity(0.8)
                                      : kGreyTextColor,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (message.giftTransaction != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.white24 : Colors.black12,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          message.giftTransaction!,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
