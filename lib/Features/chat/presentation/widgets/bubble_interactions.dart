import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vibe_zo/Features/chat/data/models/get_chat_messages_model/message.dart';
import 'package:vibe_zo/Features/chat/presentation/widgets/bubble_interaction_item.dart';
import 'package:vibe_zo/Features/chat/presentation/widgets/reactions_widget.dart';
import 'package:vibe_zo/core/utils/assets.dart';
import 'package:vibe_zo/core/utils/constants.dart';

class BubbleInteractions extends StatelessWidget {
  const BubbleInteractions({
    super.key,
    required this.message,
    required this.tapPosition,
  });

  final Message message;
  final Offset tapPosition;

  @override
  Widget build(BuildContext context) {
    final isMe = message.isFromMe!;
    final bubbleColor = isMe ? const Color(0Xccda5280) : Colors.grey[300];
    final textColor = isMe ? Colors.white : Colors.black87;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    const boxWidth = 270.0;
    const boxHeight = 330.0;

    // احسب الموضع بحيث ميطلعش برة الشاشة
    final double top = (tapPosition.dy + boxHeight > screenHeight)
        ? screenHeight - boxHeight - 20
        : tapPosition.dy;

    final double left = (tapPosition.dx + boxWidth > screenWidth)
        ? screenWidth - boxWidth - 20
        : tapPosition.dx - 20;

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              top: top,
              left: left,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: boxWidth,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe ? kPrimaryColor.withOpacity(.07) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: message.id.toString(),
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
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
                                  message.text ?? "",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateFormat(
                                    'HH:mm',
                                  ).format(message.createdAt!),
                                  style: TextStyle(
                                    color: isMe
                                        ? Colors.white.withOpacity(0.8)
                                        : kGreyTextColor,
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const ReactionsWidget(),
                      const SizedBox(height: 10),
                      ...[
                        {'icon': AssetsData.infoIcon, 'title': "Info"},
                        {'icon': AssetsData.replyIcon, 'title': "Reply"},
                        {'icon': AssetsData.copy, 'title': "Copy"},
                        {'icon': AssetsData.reportIcon, 'title': "Report"},
                        {'icon': AssetsData.trash1, 'title': "Delete for me"},
                        {'icon': AssetsData.trash, 'title': "Delete for all"},
                      ].map((item) {
                        return GestureDetector(
                          onTap: () {}, // TODO: Handle action
                          child: BubbleInteractionItem(
                            iconPath: item['icon']!,
                            title: item['title']!,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
