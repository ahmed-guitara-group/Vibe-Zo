import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/helper.dart';

import '../utils/constants.dart';
import '../utils/gaps.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? rowIconPath;
  final String? rowString;
  final String? initialValue;
  final String? hintInTextField;
  final double? fontSize;
  final bool obscureText;
  final TextInputType textInputType;
  final double? height;
  final double? width;
  final int? multiLine;
  final String? Function(String?)? validator;
  final bool isRequired;
  final void Function(String?)? onChange;
  final int? maxLength;
  const CustomTextField({
    super.key,
    this.maxLength,
    this.onChange,
    this.initialValue,
    this.width,
    this.rowString,
    this.rowIconPath,
    this.multiLine,
    this.hintInTextField,
    required this.textInputType,
    required this.obscureText,
    this.height,
    this.controller,
    this.validator,
    this.isRequired = false,
    this.fontSize,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            widget.rowIconPath != null
                ? Image.asset(
                    widget.rowIconPath!,
                    color: kPrimaryColor,
                    width: context.screenWidth * .05,
                    height: context.screenHeight * .05,
                  )
                : const SizedBox(),
            Gaps.hGap8,
            widget.rowString != null
                ? RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.top,
                          child: Transform.translate(
                            offset: const Offset(0, -5),
                            child: Text(
                              '* ',
                              style: TextStyle(
                                color: kRedTextColor,
                                fontSize: 12,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),

                        TextSpan(
                          text: widget.rowString!,
                          style: TextStyle(
                            color: kBlackTextColor,
                            fontSize: 12,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w400,
                            height: 1.17,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            Gaps.hGap8,
            widget.isRequired
                ? Icon(
                    Icons.star,
                    size: context.screenHeight * 0.013,
                    color: kRedColor,
                  )
                : Gaps.empty,
          ],
        ),
        SizedBox(
          height: widget.rowIconPath != null || widget.rowString != null
              ? context.screenHeight * .01
              : 0,
        ),
        TextFormField(
          maxLength: widget.maxLength,
          buildCounter:
              (
                context, {
                required currentLength,
                required isFocused,
                required maxLength,
              }) {
                return null;
              },

          //  initialValue: widget.initialValue,
          onChanged: widget.onChange,
          textAlignVertical: TextAlignVertical.top,
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.obscureText ? obscure : false,
          keyboardType: widget.textInputType,
          maxLines: widget.multiLine ?? 1,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            fillColor: Colors.white,
            hintStyle: const TextStyle(
              color: kGreyTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            hintText: widget.hintInTextField,

            suffix: widget.obscureText
                ? InkWell(
                    onTap: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    child: Icon(
                      obscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                      color: Colors.grey,
                    ),
                  )
                : const SizedBox(),
            errorStyle: const TextStyle(fontSize: 10, height: 0.1),
            filled: true,
            // focusedErrorBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 18,
            ), // space of text
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: kGreyTextColor, width: 1.0),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),

            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kGreyTextColor, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
