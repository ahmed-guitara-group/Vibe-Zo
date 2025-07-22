import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_zo/core/utils/constants.dart';

import '../../Features/auth/auth_welcome_screen/presentation/manager/auth_bottom_sheet/auth_bottom_sheet_cubit.dart';

class CustomAuthAppBar extends StatelessWidget {
  const CustomAuthAppBar({
    super.key,
    this.title,
    this.hasArrowBackButton = false,
  });
  final bool hasArrowBackButton;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: EdgeInsets.symmetric(horizontal: 16.0),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        title ?? "",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: const Color(0xFF161616) /* Form-text-form-title */,
          fontSize: 14,
          fontFamily: 'Lexend',
          fontWeight: FontWeight.w500,
          height: 1.29,
        ),
      ),
      leading: hasArrowBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
              onPressed: () {
                BlocProvider.of<AuthBottomSheetCubit>(
                  context,
                ).changeBottomSheetState(pageRoute: kAuthWelcomeScreenRoute);
              },
            )
          : null,
      actions: [
        CircleAvatar(
          radius: 16,
          backgroundColor: kLightGreyTextColor,
          child: IconButton(
            icon: Icon(Icons.close_rounded, color: Colors.black, size: 16),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
