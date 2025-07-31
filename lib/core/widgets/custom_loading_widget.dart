import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/assets.dart';

class CustomLoadiNgWidget extends StatelessWidget {
  const CustomLoadiNgWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AssetsData.loading, alignment: Alignment.center);
  }
}
