import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/helper.dart';

class BubbleInteractionItem extends StatelessWidget {
  const BubbleInteractionItem({
    super.key,
    required this.title,
    required this.iconPath,
  });
  final String title;
  final String iconPath;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: context.locale.isEnLocale
          ? Alignment.centerRight
          : Alignment.centerLeft,

      padding: EdgeInsetsGeometry.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: const Color(0xFF384250),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.29,
            ),
          ),
          SizedBox(width: 10),
          Image.asset(iconPath),
        ],
      ),
    );
  }
}
