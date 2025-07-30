import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vibe_zo/Features/chat/presentation/manager/get_all_chats/get_all_chats_cubit.dart';
import 'package:vibe_zo/Features/splash/domain/entity/login_entity.dart';
import 'package:vibe_zo/core/utils/helper.dart';
import 'package:vibe_zo/core/widgets/custom_loading_widget.dart';

import '../../../../core/utils/constants.dart';
import '../widgets/chats_list.dart';
import '../widgets/streamers_row.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var currentUserDataBox = Hive.box<LoginEntity>(kUserDataBox);
    var loginToken = Hive.box(kLoginTokenBox);

    BlocProvider.of<GetAllChatsCubit>(
      context,
    ).getAllChats(loginToken.get(kLoginTokenBox));

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
    return BlocBuilder<GetAllChatsCubit, GetAllChatsState>(
      builder: (context, state) {
        if (state is GetAllChatsSuccessful) {
          return Padding(
            padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
            child: Column(
              children: [
                SizedBox(
                  height: context.screenHeight * .1,
                  child: StreamersRow(allChatsModel: state.allChats),
                ),

                Expanded(child: ChatsList(allChatsModel: state.allChats)),
              ],
            ),
          );
        } else {
          return CustomLoadiNgWidget();
        }
      },
    );
  }
}
