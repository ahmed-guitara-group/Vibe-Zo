import 'package:flutter/material.dart';
import 'package:vibe_zo/Features/chat/presentation/widgets/streamers_row.dart';
import 'package:vibe_zo/core/utils/helper.dart';

import '../widgets/chats_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
      child: Column(
        children: [
          SizedBox(height: context.screenHeight * .1, child: StreamersRow()),

          Expanded(child: ChatsList()),
        ],
      ),
    );
  }
}
