import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../core/utils/constants.dart';
import '../manager/create_or_get_chat/create_or_get_chat_cubit.dart';
import '../widgets/chat_details_screen_body.dart';
import '../widgets/custom_chat_details_app_bar.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({super.key, required this.toUserId});
  final String toUserId;
  @override
  Widget build(BuildContext context) {
    var token = Hive.box(kLoginTokenBox);

    BlocProvider.of<CreateOrGetChatCubit>(
      context,
    ).createOrGetChat(token.get(kLoginTokenBox), toUserId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.07,
        ),
        child: CustomChatDetailsAppBar(),
      ),
      body: ChatDetailsScreenBody(),
    );
  }
}
