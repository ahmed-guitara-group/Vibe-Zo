import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vibe_zo/Features/chat/presentation/widgets/streamers_row.dart';
import 'package:vibe_zo/Features/splash/domain/entity/login_entity.dart';
import 'package:vibe_zo/core/utils/helper.dart';

import '../../../../core/utils/constants.dart';
import '../widgets/chats_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var currentUserDataBox = Hive.box<LoginEntity>(kUserDataBox);
    print(currentUserDataBox.getAt(0)!.id.toString());
    //ALL CHATS
    // SocketManager().initSocketForChannel(
    //   //cURRENT USER ID
    //   userId: currentUserDataBox.getAt(0)!.id.toString(),
    //   channelName: "chats/${currentUserDataBox.getAt(0)!.id.toString()}",
    // );
    //FOR ONE CHAT
    // SocketManager().initSocketForChannel(
    //   //cURRENT USER ID
    //   userId: currentUserDataBox.getAt(0)!.id.toString(),
    //   channelName: "chat/CHAT_ID",
    // );

    // SocketManager().chatSocket.emit('sendMessage', {
    //   'senderId': '123',
    //   'receiverId': '456',
    //   'message': 'Hello from Flutter!',
    //   'timestamp': DateTime.now().toIso8601String(),
    // });
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
