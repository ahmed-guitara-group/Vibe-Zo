import 'package:flutter/material.dart';

class GenderSelector extends StatefulWidget {
  final Function(String gender) onGenderSelected;

  const GenderSelector({super.key, required this.onGenderSelected});

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
        widget.onGenderSelected(value); // <-- هنا بنبعت القيمه للشاشة الأم
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
