import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/helper.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/constants.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({
    super.key,

    this.hasSearchIcon = false,
    this.titleWidget,
    this.leadingWidget,
    this.actions,
  });

  final bool hasSearchIcon;
  final Widget? titleWidget;
  final Widget? leadingWidget;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    // var box = Hive.box<LoginEntity>(kUserDataBox);
    // var imageBox = Hive.box(kUserImageBox);
    // final String? imagePath = imageBox.get('image');
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsData.appBarBackGround),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: kGreyBtnColor, width: 2),
              ),
            ),
            child: AppBar(
              leadingWidth: context.screenWidth * .1,
              title: titleWidget,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              leading: leadingWidget,
              titleSpacing: 0,

              actionsPadding: EdgeInsets.symmetric(horizontal: 16),
              actions:
                  actions ??
                  [
                    hasSearchIcon
                        ? InkWell(
                            onTap: () {},
                            child: Image.asset(
                              AssetsData.searchIcon,
                              height: 20,
                              width: 20,
                            ),
                          )
                        : SizedBox(),
                  ],
            ),
          ),
        ),
      ],
    );
  }
}
