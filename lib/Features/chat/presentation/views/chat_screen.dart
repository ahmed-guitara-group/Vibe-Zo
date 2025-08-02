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

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final String userId;
  late final String channelId;
  late final GetAllChatsCubit chatsCubit;

  @override
  void initState() {
    super.initState();

    final userBox = Hive.box<LoginEntity>(kUserDataBox);
    final tokenBox = Hive.box(kLoginTokenBox);
    final token = tokenBox.get(kLoginTokenBox);

    final loginEntity = userBox.getAt(0)!;
    userId = loginEntity.id.toString();
    channelId = loginEntity.id.toString();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      chatsCubit = context.read<GetAllChatsCubit>(); // 👈 خزن المرجع هنا

      chatsCubit.connectAllChatSocket(userId: userId, channelId: channelId);

      chatsCubit.getAllChats(token);
    });
  }

  @override
  void dispose() {
    chatsCubit.disconnectAllChatSocket(channelId: channelId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllChatsCubit, GetAllChatsState>(
      builder: (context, state) {
        if (state is GetAllChatsSuccessful) {
          return Padding(
            padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
            child: RefreshIndicator(
              onRefresh: () async {
                final tokenBox = Hive.box(kLoginTokenBox);
                final token = tokenBox.get(kLoginTokenBox);
                context.read<GetAllChatsCubit>().getAllChats(token);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.screenHeight * .1,
                    child: StreamersRow(allChatsModel: state.allChats),
                  ),
                  Expanded(child: ChatsList(allChatsModel: state.allChats)),
                ],
              ),
            ),
          );
        } else {
          return const CustomLoadiNgWidget();
        }
      },
    );
  }
}
