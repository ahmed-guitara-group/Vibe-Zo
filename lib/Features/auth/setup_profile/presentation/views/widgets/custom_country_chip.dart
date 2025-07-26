import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/constants.dart';

class CustomCountryChip extends StatelessWidget {
  final String name;
  final Widget? flag;
  final bool isSelected;
  final VoidCallback onSelect;

  const CustomCountryChip({
    super.key,
    required this.name,
    this.flag,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onSelect,
      icon: flag,
      label: Text(name),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: kPrimaryColor),
        foregroundColor: isSelected ? Colors.white : kPrimaryColor,
        backgroundColor: isSelected ? kPrimaryColor : Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        textStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}
