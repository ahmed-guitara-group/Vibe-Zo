import 'package:flutter/material.dart';
import 'package:vibe_zo/Features/chat/presentation/widgets/chat_field.dart';

import '../../data/models/get_chat_messages_model/message.dart';
import 'chat_bubble.dart';

class ChatDetailsScreenBody extends StatefulWidget {
  const ChatDetailsScreenBody({
    super.key,
    required this.messages,
    required this.currentUserId,
  });

  final List<Message> messages;
  final String currentUserId;

  @override
  State<ChatDetailsScreenBody> createState() => _ChatDetailsScreenBodyState();
}

class _ChatDetailsScreenBodyState extends State<ChatDetailsScreenBody> {
  Message? repliedTo;

  bool _shouldShowAvatar(int index, List<Message> messages) {
    if (index == 0) return true;
    final current = messages[index];
    final previous = messages[index - 1];
    return current.sender?.id != previous.sender?.id;
  }

  @override
  Widget build(BuildContext context) {
    final reversedMessages = widget.messages.reversed.toList();

    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              reverse: true,
              itemCount: reversedMessages.length,
              itemBuilder: (context, index) {
                final message = reversedMessages[index];
                final isMe = message.isFromMe ?? false;
                final showAvatar = _shouldShowAvatar(index, reversedMessages);
                return ChatBubble(
                  message: message,
                  isMe: isMe,
                  showAvatar: showAvatar,
                  onReply: (msg) {
                    setState(() {
                      repliedTo = msg;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: ChatField(
              repliedTo: repliedTo,
              onCancelReply: () {
                setState(() {
                  repliedTo = null;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
