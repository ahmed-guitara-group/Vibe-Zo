import 'package:flutter/material.dart';

class CustomAuthAppBar extends StatelessWidget {
  const CustomAuthAppBar({
    super.key,
    this.title,
    this.hasArrowBackButton = false,
    this.onBackButtonPressed,
  });
  final bool hasArrowBackButton;
  final String? title;
  final Function? onBackButtonPressed;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),

      leadingWidth: 20,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        title ?? "",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: const Color(0xFF161616),
          fontSize: 14,
          fontFamily: 'Lexend',
          fontWeight: FontWeight.w500,
          height: 1.29,
        ),
      ),
      leading: hasArrowBackButton
          ? IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
                size: 16,
              ),
              onPressed: () {
                if (onBackButtonPressed != null) {
                  onBackButtonPressed!();
                }
              },
            )
          : null,
      // actions: [
      //   CircleAvatar(
      //     radius: 16,
      //     backgroundColor: kLightGreyTextColor,
      //     child: IconButton(
      //       icon: Icon(Icons.close_rounded, color: Colors.black, size: 16),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ),
      // ],
    );
  }
}
