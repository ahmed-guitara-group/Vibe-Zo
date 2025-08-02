import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vibe_zo/Features/splash/domain/entity/login_entity.dart';
import 'package:vibe_zo/core/utils/network/api/network_api.dart';
import 'package:vibe_zo/core/widgets/custom_loading_widget.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/socket_manager/socket_manager.dart';
import '../manager/chat_messages_manager_cubit/chat_messages_manager_cubit_cubit.dart';
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
  String? _chatId;
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
  void dispose() {
    // افصل السوكيت عند الخروج من الشاشة
    if (_chatId != null) {
      SocketManager().disconnectSocket("chat/$_chatId");
      SocketManager().disposeSocket("chat/$_chatId");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrGetChatCubit, CreateOrGetChatState>(
      builder: (context, state) {
        if (state is CreateOrGetChatSuccessful) {
          final chatId = state.response.chat!.id.toString();

          // اتأكد إنك تحفظ الـ chatId
          if (!_chatFetched) {
            _chatId = chatId;

            // جلب الرسائل
            context.read<GetChatMessagesCubit>().getChatMessages(token, chatId);

            // الاتصال بالسوكيت
            context.read<GetChatMessagesCubit>().connectChatSocket(
              chatId: chatId,
              userId: currentUserId,
            );

            _chatFetched = true;
          }

          return BlocListener<GetChatMessagesCubit, GetChatMessagesState>(
            listener: (context, state) {
              if (state is GetChatMessagesSuccessful) {
                context.read<ChatMessagesManagerCubit>().loadInitialMessages(
                  state.chatMessages.chat!.messages!,
                );
              } else if (state is NewMessageReceived) {
                
                context.read<ChatMessagesManagerCubit>().addLocalMessage(
                  state.message,
                );
              }
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                  MediaQuery.of(context).size.height * 0.07,
                ),
                child: CustomChatDetailsAppBar(
                  imageUrl:
                      Api.baseImageUrl +
                      state
                          .response
                          .chat!
                          .otherUser!
                          .profilePhoto!
                          .photo!
                          .name!,
                  title: state.response.chat!.otherUser!.name!,
                ),
              ),
              body: ChatDetailsScreenBody(
                chatId: _chatId!,
                currentUserId: currentUserId,
              ),
            ),
          );
        } else {
          return const Scaffold(body: Center(child: CustomLoadiNgWidget()));
        }
      },
    );
  }
}
