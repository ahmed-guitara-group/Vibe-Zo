import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/constants.dart';
import 'package:vibe_zo/core/utils/helper.dart';

class ReactionsWidget extends StatelessWidget {
  const ReactionsWidget({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> reactions = ["👍", "❤️", "😂", "😢", "😡", "😎"];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: reactions.map((e) {
          return Container(
            margin: EdgeInsets.only(
              left: context.locale.isEnLocale ? 4 : 0,
              right: context.locale.isEnLocale ? 0 : 4,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
              onTap: () {
                // Do react to the message
                print(e);
              },
              child: Text(e, style: const TextStyle(fontSize: 12)),
            ),
          );
        }).toList(),
      ),
    );
  }
}
