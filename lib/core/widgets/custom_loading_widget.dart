import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/constants.dart';

class CustomLoadiNgWidget extends StatelessWidget {
  const CustomLoadiNgWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: const CircularProgressIndicator(color: kPrimaryColor));
  }
}
