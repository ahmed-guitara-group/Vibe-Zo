import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/assets.dart';
import 'package:vibe_zo/core/utils/constants.dart';
import 'package:vibe_zo/core/utils/helper.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(title, style: TextStyle(fontSize: 18, color: kPrimaryColor)),
      content: Image.asset(
        AssetsData.errorImage,
        height: context.screenHeight * .2,
        width: context.screenHeight * .2,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Close", style: TextStyle(color: kPrimaryColor)),
        ),
      ],
    );
  }
}
