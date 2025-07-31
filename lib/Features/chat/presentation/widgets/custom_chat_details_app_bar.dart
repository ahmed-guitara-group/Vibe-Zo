import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/helper.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/gaps.dart';
import '../../../home/presentation/widgets/custom_home_app_bar_widget.dart';
import 'custom_chat_title.dart';
import 'custom_level_container.dart';

class CustomChatDetailsAppBar extends StatelessWidget {
  const CustomChatDetailsAppBar({
    super.key,
    required this.title,
    required this.imageUrl,
  });
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CustomHomeAppBar(
      leadingWidget: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset(AssetsData.arrowBack),
      ),
      hasSearchIcon: false,
      titleWidget: Row(
        children: [
          CircleAvatar(
            backgroundColor: kWhiteColor,
            child: ClipOval(
              child: imageUrl != ""
                  ? Image.network(
                      imageUrl,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      AssetsData.addUser,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Gaps.hGap4,

          /// ✅ Expanded يمنع الـ overflow
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomChatTitle(
                  isPinnedChat: false,
                  isExpanded: false,
                  isChatDetailsBar: true,
                  userName: title,
                ),
                Gaps.vGap4,
                CustomLevelContainer(
                  backgroundColor: Color(0xFFAE4266),
                  borderColor: Color(0xFFAE4266),
                  textColor: kWhiteColor,
                  text: "Live Now",
                  iconPath: AssetsData.liveIcon,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            InkWell(
              onTap: () {},
              child: CircleAvatar(
                radius: context.screenWidth * .04,
                backgroundColor: kPrimaryColor,
                child: Image.asset(
                  AssetsData.addUser,
                  width: context.screenWidth * .04,
                  height: context.screenWidth * .04,
                ),
              ),
            ),
            Gaps.hGap8,
            InkWell(
              onTap: () {},
              child: Image.asset(
                AssetsData.moreIcon,
                width: context.screenWidth * .06,
                height: context.screenWidth * .06,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
