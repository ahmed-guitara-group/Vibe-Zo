import 'package:flutter/material.dart';

import '../widgets/chat_details_screen_body.dart';
import '../widgets/custom_chat_details_app_bar.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
