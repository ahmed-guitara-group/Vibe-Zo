import 'package:flutter/material.dart';
import 'package:vibe_zo/Features/chat/presentation/widgets/chat_field.dart';

import 'chat_bubble.dart';

class ChatDetailsScreenBody extends StatefulWidget {
  const ChatDetailsScreenBody({super.key});

  @override
  State<ChatDetailsScreenBody> createState() => _ChatDetailsScreenBodyState();
}

class _ChatDetailsScreenBodyState extends State<ChatDetailsScreenBody> {
  final String currentUserId = '123';

  final List<Message> messages = List.generate(
    50,
    (index) => Message(
      react: '❤️',
      id: index.toString(),
      senderId: index % 3 == 0 ? '123' : '456',
      content: 'رسالة رقم $index',
      timestamp: DateTime.now().subtract(Duration(minutes: index * 3)),
      type: MessageType.text,
    ),
  );

  Message? repliedTo;

  bool _shouldShowAvatar(int index) {
    if (index == 0) return true;

    final current = messages[index];
    final previous = messages[index - 1];

    return current.senderId != previous.senderId;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isMe = message.senderId == currentUserId;
                final showAvatar = _shouldShowAvatar(index);
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
