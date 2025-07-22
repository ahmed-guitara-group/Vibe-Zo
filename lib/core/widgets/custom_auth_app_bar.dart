import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/constants.dart';

class CustomAuthAppBar extends StatelessWidget {
  const CustomAuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: EdgeInsets.symmetric(horizontal: 20.0),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      actions: [
        CircleAvatar(
          radius: 16,
          backgroundColor: kLightGreyTextColor,
          child: IconButton(
            icon: Icon(Icons.close_rounded, color: Colors.black, size: 16),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
