import 'package:flutter/material.dart';

import '../../../../../core/utils/constants.dart';

class CustomOrRowWidget extends StatelessWidget {
  const CustomOrRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: kDividerColor, thickness: 1.5, endIndent: 10),
        ),
        Text(
          'Or',
          style: TextStyle(
            color: const Color(0xFF6C727E) /* Text-text-secondary-paragraph */,
            fontSize: 32,
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w500,
            height: 1.25,
            letterSpacing: -0.64,
          ),
        ),
        const Expanded(
          child: Divider(color: kDividerColor, thickness: 1.5, indent: 10),
        ),
      ],
    );
  }
}
