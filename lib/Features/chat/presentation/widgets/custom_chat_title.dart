import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/assets.dart';
import 'custom_level_container.dart';

class CustomChatTitle extends StatelessWidget {
  const CustomChatTitle({
    super.key,
    required this.isPinnedChat,
    required this.isExpanded,
    required this.isChatDetailsBar,
    required this.userName,
  });
  final bool isPinnedChat;
  final bool isExpanded;
  final bool isChatDetailsBar;
  final String? userName;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isPinnedChat) CustomLevelContainer(),
        SizedBox(width: 4),

        Flexible(
          child: Row(
            children: [
              Flexible(
                child: Text(
                  isPinnedChat ? 'Vibe Zo Team Middle East' : userName ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF1F2A37),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.17,
                  ),
                ),
              ),
              if (!isPinnedChat) ...[
                SizedBox(width: 4),
                Image.asset(AssetsData.verifiedIcon, width: 16, height: 16),
                SizedBox(width: 4),
                CountryFlag.fromCountryCode(
                  "EG",
                  shape: RoundedRectangle(4),
                  height: 18,
                  width: 18,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
