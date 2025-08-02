import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vibe_zo/Features/chat/presentation/widgets/bubble_interactions.dart';
import 'package:vibe_zo/core/utils/assets.dart';
import 'package:vibe_zo/core/utils/constants.dart';
import 'package:vibe_zo/core/utils/gaps.dart';
import 'package:vibe_zo/core/utils/helper.dart';

import '../../data/models/get_chat_messages_model/message.dart';
import '../manager/send_message/send_message_cubit.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final bool showAvatar;

  final void Function(Message)? onReply;
  final String otherUserImgUrl;
  const ChatBubble({
    super.key,
    required this.otherUserImgUrl,
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
        onLongPressStart: (details) {
          showGeneralDialog(
            context: context,
            barrierLabel: 'Bubble Interactions',
            barrierDismissible: true,
            barrierColor: Colors.black.withOpacity(0.2),
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (context, animation, secondaryAnimation) {
              return Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(color: Colors.transparent),
                  ),
                  BubbleInteractions(
                    message: message,
                    tapPosition: details.globalPosition,
                  ),
                ],
              );
            },
          );
        },

        child: Row(
          mainAxisAlignment: isMe
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMe)
              showAvatar
                  ? CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: context.screenWidth * .04,
                      backgroundImage: NetworkImage(otherUserImgUrl),
                    )
                  : SizedBox(
                      width: context.screenWidth * .08,
                      height: context.screenWidth * .08,
                    ),

            if (!isMe) Gaps.hGap8,

            Flexible(
              child: Stack(
                alignment: isMe ? Alignment.bottomLeft : Alignment.bottomRight,
                children: [
                  Hero(
                    tag: message.id.toString(),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      margin: message.giftTransaction != null
                          ? const EdgeInsets.only(bottom: 10)
                          : const EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: bubbleColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(isMe ? 12 : 12),
                          topRight: Radius.circular(isMe ? 12 : 12),
                          bottomLeft: Radius.circular(
                            isMe
                                ? 12
                                : showAvatar
                                ? 0
                                : 12,
                          ),
                          bottomRight: Radius.circular(
                            isMe && showAvatar ? 0 : 12,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.text ?? "",
                            style: TextStyle(
                              color: textColor,
                              fontSize: context.screenWidth * 0.033,
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
                                BlocBuilder<SendMessageCubit, SendMessageState>(
                                  builder: (context, state) {
                                    return CircleAvatar(
                                      maxRadius: context.screenWidth * 0.02,
                                      backgroundColor: const Color(0X33DA5280),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Builder(
                                          builder: (context) {
                                            if (state is SendMessageLoading &&
                                                message.isLocal == true) {
                                              return Image.asset(
                                                AssetsData.addUser,
                                              );
                                            }

                                            if (state is SendMessageFailed &&
                                                message.isLocal == true) {
                                              return Image.asset(
                                                AssetsData.errorImage,
                                              );
                                            }

                                            return Image.asset(AssetsData.seen);
                                          },
                                        ),
                                      ),
                                    );
                                  },
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
    );
  }
}
