import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/assets.dart';

class CustomLevelContainer extends StatelessWidget {
  const CustomLevelContainer({
    super.key,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.width,
    this.height,
    this.text,
    this.iconPath,
  });
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final String? text;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 20,
      padding: const EdgeInsets.all(5),
      decoration: ShapeDecoration(
        color: backgroundColor ?? const Color(0xFFEFF8FF),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: borderColor ?? const Color(0xFFB2DDFF),
          ),
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 4,
        children: [
          Image.asset(
            iconPath ?? AssetsData.levelIcon,
            fit: BoxFit.cover,
            width: iconPath == AssetsData.liveIcon ? 14 : null,
          ),
          Text(
            text ?? 'Level 1',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor ?? const Color(0xFF1849A9),
              fontSize: 8,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}
