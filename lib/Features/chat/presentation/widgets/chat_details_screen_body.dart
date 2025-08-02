import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_zo/Features/chat/presentation/widgets/chat_field.dart';

import '../../../../core/utils/socket_manager/socket_manager.dart';
import '../../data/models/get_chat_messages_model/message.dart';
import '../manager/chat_messages_manager_cubit/chat_messages_manager_cubit_cubit.dart';
import 'chat_bubble.dart';

class ChatDetailsScreenBody extends StatefulWidget {
  const ChatDetailsScreenBody({
    super.key,
    //  required this.messages,
    required this.currentUserId,
    required this.chatId,
  });

  //  final List<Message> messages;
  final String currentUserId;
  final String chatId;

  @override
  State<ChatDetailsScreenBody> createState() => _ChatDetailsScreenBodyState();
}

class _ChatDetailsScreenBodyState extends State<ChatDetailsScreenBody> {
  Message? repliedTo;

  @override
  void dispose() {
    SocketManager().disconnectSocket(widget.chatId);
    super.dispose();
  }

  bool _shouldShowAvatar(int index, List<Message> messages) {
    if (index == 0) return true;
    final current = messages[index];
    final previous = messages[index - 1];
    return current.sender?.id != previous.sender?.id;
  }

  @override
  Widget build(BuildContext context) {
    // final reversedMessages = widget.messages.reversed.toList();

    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
      child: Column(
        children: [
          Expanded(
            child:
                BlocBuilder<ChatMessagesManagerCubit, ChatMessagesManagerState>(
                  builder: (context, state) {
                    if (state is ChatMessagesUpdated) {
                      final reversedMessages = state.messages;

                      return ListView.builder(
                        reverse: true,
                        itemCount: reversedMessages.length,
                        itemBuilder: (context, index) {
                          final message = reversedMessages[index];
                          final isMe = message.isFromMe ?? false;
                          final showAvatar = _shouldShowAvatar(
                            index,
                            reversedMessages,
                          );

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
                      );
                    }

                    // Default loading / empty state
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: ChatField(
              chatId: widget.chatId,
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
