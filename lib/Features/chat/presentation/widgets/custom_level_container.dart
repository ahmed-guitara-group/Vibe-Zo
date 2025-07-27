import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/assets.dart';

class CustomLevelContainer extends StatelessWidget {
  const CustomLevelContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: const EdgeInsets.all(5),
      decoration: ShapeDecoration(
        color: const Color(0xFFEFF8FF),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFFB2DDFF)),
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 4,
        children: [
          Image.asset(AssetsData.levelIcon),
          Text(
            'Level 1',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF1849A9),
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
