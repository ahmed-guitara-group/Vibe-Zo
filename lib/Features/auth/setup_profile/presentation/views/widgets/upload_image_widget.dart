import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vibe_zo/core/utils/constants.dart';
import 'package:vibe_zo/core/utils/helper.dart';

class ProfileImagePicker extends StatefulWidget {
  final String initials;
  final Function(File) onImagePicked;

  const ProfileImagePicker({
    super.key,
    required this.initials,
    required this.onImagePicked,
  });

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
      widget.onImagePicked(_pickedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: const Color(0xFFF5F6F8),
          backgroundImage: _pickedImage != null
              ? FileImage(_pickedImage!)
              : null,
          child: _pickedImage == null
              ? Text(
                  widget.initials,
                  style: const TextStyle(fontSize: 16, color: kBlackTextColor),
                )
              : null,
        ),
        Positioned(
          bottom: -12,
          left: context.screenWidth / 2 - 8,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
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
