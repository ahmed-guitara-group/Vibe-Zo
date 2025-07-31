import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/constants.dart';
import 'package:vibe_zo/core/utils/helper.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/network/api/network_api.dart';
import '../../data/models/get_all_chats_model/get_all_chats_model.dart';
import 'custom_chat_title.dart';

class CustomChatItem extends StatelessWidget {
  const CustomChatItem({
    super.key,
    required this.isPinnedChat,
    required this.index,
    required this.allChatsModel,
  });
  final bool isPinnedChat;
  final int index;
  final GetAllChatsModel allChatsModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          kChatDetailsScreenRoute,
          arguments: allChatsModel.data!.users![index].id.toString(),
        );
      },
      contentPadding: EdgeInsets.all(0),
      leading: SizedBox(
        width: context.screenWidth * .13,
        height: context.screenWidth * .13,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 2,
              left: 2,
              child: Container(
                width: context.screenWidth * .15,
                height: context.screenWidth * .15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isPinnedChat
                      ? const LinearGradient(
                          begin: Alignment(-0.00, 1.00),
                          end: Alignment(1.00, -0.00),
                          colors: [Color(0xFFDA5280), Color(0xFFAAD7F3)],
                        )
                      : null,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: isPinnedChat
                      ? Image.asset(AssetsData.vZLogoWhite)
                      : allChatsModel
                                .data!
                                .chats![index]
                                .otherUser!
                                .profilePhoto !=
                            null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(9999),
                          child: ClipOval(
                            child: Image.network(
                              Api.baseImageUrl +
                                  allChatsModel
                                      .data!
                                      .chats![index]
                                      .otherUser!
                                      .profilePhoto!
                                      .photo!
                                      .name!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Image.network(
                          "https://i.pravatar.cc/300",

                          // Api.baseImageUrl +
                          //     allChatsModel
                          //         .data!
                          //         .chats![index]
                          //         .otherUser!
                          //         .profilePhoto!
                          //         .photo!
                          //         .name!,
                        ),
                ),
              ),
            ),
            if (isPinnedChat)
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(AssetsData.pinIcon, width: 20, height: 20),
              ),
          ],
        ),
      ),

      title: CustomChatTitle(
        userName: allChatsModel.data!.chats![index].otherUser!.name!,
        isPinnedChat: isPinnedChat,
        isExpanded: true,
        isChatDetailsBar: false,
      ),

      subtitle: Text(
        allChatsModel.data!.chats![index].lastMessage != null
            ? allChatsModel.data!.chats![index].lastMessage!.text != null
                  ? allChatsModel.data!.chats![index].lastMessage!.text!
                  : ""
            : "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: const Color(0xFFA3A3A3),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.33,
          letterSpacing: 0.40,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '4h ago',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF1F2A37) /* Tag-tag-text-neutral */,
              fontSize: 8,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
          SizedBox(height: 4),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            width: 16,
            height: 16,
            child: Text(
              '1',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 10, height: 1.50),
            ),
          ),
        ],
      ),
    );
  }
}
