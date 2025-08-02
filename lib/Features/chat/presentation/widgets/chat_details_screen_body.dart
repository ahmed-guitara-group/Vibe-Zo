import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vibe_zo/Features/chat/presentation/widgets/chat_field.dart';
import 'package:vibe_zo/core/utils/helper.dart';

import '../../../../core/utils/socket_manager/socket_manager.dart';
import '../../data/models/get_chat_messages_model/message.dart';
import '../manager/chat_messages_manager_cubit/chat_messages_manager_cubit_cubit.dart';
import 'chat_bubble.dart';

class ChatDetailsScreenBody extends StatefulWidget {
  const ChatDetailsScreenBody({
    super.key,
    required this.currentUserId,
    required this.chatId,
    required this.othUserImgUrl,
  });

  final String currentUserId;
  final String chatId;
  final String othUserImgUrl;

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

  bool isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  bool isSameMinute(DateTime d1, DateTime d2) {
    return d1.year == d2.year &&
        d1.month == d2.month &&
        d1.day == d2.day &&
        d1.hour == d2.hour &&
        d1.minute == d2.minute;
  }

  String formatMessageDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDay = DateTime(date.year, date.month, date.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (messageDay == today) {
      return "Today";
    } else if (messageDay == yesterday) {
      return "Yesterday";
    } else {
      return DateFormat.yMMMMd().format(date); // July 31, 2025
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatMessagesManagerCubit, ChatMessagesManagerState>(
              builder: (context, state) {
                if (state is ChatMessagesUpdated) {
                  final reversedMessages = state.messages;

                  return ListView.builder(
                    reverse: true,
                    itemCount: reversedMessages.length,
                    itemBuilder: (context, index) {
                      final message = reversedMessages[index];
                      final isMe = message.isFromMe ?? false;
                      final messageDate = message.createdAt!;

                      // ------------------------------
                      // Show date divider if this message is from a different day than the next one
                      bool showDateDivider = false;
                      if (index == reversedMessages.length - 1) {
                        showDateDivider = true;
                      } else {
                        final nextDate = reversedMessages[index + 1].createdAt!;
                        showDateDivider = !isSameDay(messageDate, nextDate);
                      }

                      // ------------------------------
                      // Show avatar logic
                      bool showAvatar = false;
                      if (index == 0) {
                        showAvatar = true;
                      } else {
                        final prev = reversedMessages[index - 1];
                        final sameSender =
                            prev.sender?.id == message.sender?.id;
                        final sameTime = isSameMinute(
                          prev.createdAt!,
                          message.createdAt!,
                        );
                        showAvatar = !(sameSender && sameTime);
                      }

                      return Column(
                        children: [
                          if (showDateDivider)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    formatMessageDate(messageDate),
                                    style: TextStyle(
                                      fontSize: context.screenWidth * 0.03,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ChatBubble(
                            otherUserImgUrl: widget.othUserImgUrl,
                            message: message,
                            isMe: isMe,
                            showAvatar: showAvatar,
                            onReply: (msg) {
                              setState(() {
                                repliedTo = msg;
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                }

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
