import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/assets.dart';
import 'package:vibe_zo/core/utils/helper.dart';
import 'package:vibe_zo/core/utils/network/api/network_api.dart';

import '../../../../core/utils/constants.dart';
import '../../data/models/get_all_chats_model/get_all_chats_model.dart';

class StreamersRow extends StatelessWidget {
  const StreamersRow({super.key, required this.allChatsModel});
  final GetAllChatsModel allChatsModel;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      itemCount: allChatsModel.data!.users!.length,
      separatorBuilder: (context, index) {
        return SizedBox(width: 10);
      },
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              kChatDetailsScreenRoute,
              arguments: allChatsModel.data!.users![index].id.toString(),
            );
          },
          child: CircleAvatar(
            radius: context.screenWidth * .07,
            backgroundImage:
                allChatsModel.data!.users![index].profilePhoto == null
                ? AssetImage(AssetsData.vZLogo)
                : NetworkImage(
                    Api.baseImageUrl +
                        allChatsModel
                            .data!
                            .users![index]
                            .profilePhoto!
                            .photo!
                            .name!,
                  ),
          ),
        );
      },
    );
  }
}
