import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vibe_zo/core/utils/assets.dart';
import 'package:vibe_zo/core/utils/constants.dart';
import 'package:vibe_zo/core/utils/gaps.dart';
import 'package:vibe_zo/core/utils/helper.dart';

enum MessageType { text, audio }

class Message {
  final String id;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final MessageType type;
  final String? react;

  Message({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.type,
    this.react,
  });
}

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final bool showAvatar;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.showAvatar,
  });

  @override
  Widget build(BuildContext context) {
    // final alignment = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleColor = isMe ? Color(0Xccda5280) : Colors.grey[300];
    final textColor = isMe ? Colors.white : Colors.black87;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 16,
            backgroundImage: showAvatar
                ? NetworkImage(
                    'https://i.pravatar.cc/150?u=${message.senderId}',
                  )
                : null,
          ),
        const SizedBox(width: 8),
        Stack(
          alignment: isMe ? Alignment.bottomLeft : Alignment.bottomRight,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.screenWidth * 0.60),
              child: IntrinsicWidth(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  margin: message.react != null
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
                      Text(
                        int.tryParse(message.id) != null &&
                                int.parse(message.id) % 2 == 0
                            ? message.content
                            : message.content * 5,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          height: 1.17,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
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
                            DateFormat('HH:mm').format(message.timestamp),
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
              ),
            ),
            if (message.react != null)
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
                  message.react!,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
