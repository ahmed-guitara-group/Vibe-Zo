import 'package:flutter/material.dart';
import 'package:vibe_zo/Features/chat/presentation/widgets/chat_field.dart';

import 'chat_bubble.dart';

class ChatDetailsScreenBody extends StatelessWidget {
  ChatDetailsScreenBody({super.key});

  final String currentUserId = '123'; // المستخدم الحالي

  final List<Message> messages = List.generate(
    50,
    (index) => Message(
      react: '❤️',
      id: index.toString(),
      senderId: index % 3 == 0 ? '123' : '456', // كل 3 رسائل من المستخدم الحالي
      content: 'رسالة رقم $index',
      timestamp: DateTime.now().subtract(Duration(minutes: index * 3)),
      type: MessageType.text,
    ),
  );

  bool _shouldShowAvatar(int index) {
    if (index == 0) return true; // أول رسالة (أحدث) لازم يظهر فيها الأفاتار

    final current = messages[index];
    final previous = messages[index - 1]; // لأننا reverse

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
                return Dismissible(
                  key: ValueKey(message.id),
                  direction: DismissDirection.startToEnd,
                  confirmDismiss: (direction) async {
                    return false;
                  },
                  child: GestureDetector(
                    onLongPress: () {
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return Center(
                            child: Container(
                              color: Colors.red,
                              child: Text("data"),
                            ),
                          );
                        },
                      );
                    },
                    child: ChatBubble(
                      message: message,
                      isMe: isMe,
                      showAvatar: showAvatar,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: ChatField(),
          ),
        ],
      ),
    );
  }
}
