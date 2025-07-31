import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vibe_zo/Features/splash/domain/entity/login_entity.dart';
import 'package:vibe_zo/core/utils/network/api/network_api.dart';
import 'package:vibe_zo/core/widgets/custom_loading_widget.dart';

import '../../../../core/utils/constants.dart';
import '../manager/create_or_get_chat/create_or_get_chat_cubit.dart';
import '../manager/get_chat_messages/get_chat_messages_cubit.dart';
import '../widgets/chat_details_screen_body.dart';
import '../widgets/custom_chat_details_app_bar.dart';

class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({super.key, required this.toUserId});
  final String toUserId;

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  late final String token;
  late final String currentUserId;

  bool _chatFetched = false;

  @override
  void initState() {
    super.initState();
    final tokenBox = Hive.box(kLoginTokenBox);
    final currentUserData = Hive.box<LoginEntity>(kUserDataBox);
    token = tokenBox.get(kLoginTokenBox);
    currentUserId = currentUserData.getAt(0)!.id.toString();

    context.read<CreateOrGetChatCubit>().createOrGetChat(
      token,
      widget.toUserId,
    );
  }

  @override

  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrGetChatCubit, CreateOrGetChatState>(
      builder: (context, state) {
        if (state is CreateOrGetChatSuccessful) {
          final chatId = state.response.chat!.id.toString();
          //Connect to socket
          BlocProvider.of<CreateOrGetChatCubit>(
            context,
          ).connectChatSocket(userId: currentUserId, channelId: chatId);
          if (!_chatFetched) {
            context.read<GetChatMessagesCubit>().getChatMessages(token, chatId);
            _chatFetched = true;
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                MediaQuery.of(context).size.height * 0.07,
              ),
              child: CustomChatDetailsAppBar(
                imageUrl:
                    Api.baseImageUrl +
                    state.response.chat!.otherUser!.profilePhoto!.photo!.name!,
                title: state.response.chat!.otherUser!.name!,
              ),
            ),
            body: BlocBuilder<GetChatMessagesCubit, GetChatMessagesState>(
              builder: (context, state) {
                return state is GetChatMessagesSuccessful
                    ? ChatDetailsScreenBody(
                        chatId: state.chatMessages.chat!.id.toString(),
                        currentUserId: currentUserId,
                        messages: state.chatMessages.chat!.messages!,
                      )
                    : const Center(child: CircularProgressIndicator());
              },
            ),
          );
        } else {
          return const Scaffold(body: Center(child: CustomLoadiNgWidget()));
        }
      },
    );
  }
}
