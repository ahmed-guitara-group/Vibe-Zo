import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/constants.dart';
import 'package:vibe_zo/core/utils/helper.dart';

class ProfileImagePicker extends StatelessWidget {
  final String initials;
  final VoidCallback onTap;

  const ProfileImagePicker({
    super.key,
    required this.initials,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: const Color(0xFFF5F6F8),
          child: Text(
            initials,
            style: const TextStyle(
              fontSize: 16,
              color: kBlackTextColor,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Positioned(
          bottom: -12,
          left: context.screenWidth / 2 - 8,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.add, color: kBlackTextColor, size: 25),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GenderSelector extends StatefulWidget {
  const GenderSelector({super.key});

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGenderButton(
          label: "Female",
          icon: Icons.female,
          color: Colors.pink,
          value: "female",
        ),
        const SizedBox(width: 12),
        _buildGenderButton(
          label: "Male",
          icon: Icons.male,
          color: Colors.blue,
          value: "male",
        ),
      ],
    );
  }

  Widget _buildGenderButton({
    required String label,
    required IconData icon,
    required Color color,
    required String value,
  }) {
    final isSelected = selectedGender == value;
    return OutlinedButton.icon(
      onPressed: () {
        setState(() {
          selectedGender = value;
        });
      },
      icon: Icon(icon, color: isSelected ? Colors.white : color),
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : color,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        backgroundColor: isSelected ? color : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
