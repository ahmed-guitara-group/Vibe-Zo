import 'package:flutter/material.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/constants.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key, required this.tapHandler});
  final Function tapHandler;

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
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              actionsPadding: EdgeInsets.symmetric(horizontal: 16),
              actions: [
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    AssetsData.searchIcon,
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
