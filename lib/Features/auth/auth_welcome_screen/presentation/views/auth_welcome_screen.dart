import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_zo/core/utils/assets.dart';
import 'package:vibe_zo/core/utils/gaps.dart';
import 'package:vibe_zo/core/utils/helper.dart';
import 'package:vibe_zo/core/widgets/custom_auth_app_bar.dart';
import 'package:vibe_zo/core/widgets/custom_button.dart';

import '../../../../../core/utils/constants.dart';
import '../../data/models/auth_type_model.dart';
import '../manager/auth_bottom_sheet/auth_bottom_sheet_cubit.dart';
import '../widgets/custom_or_row.dart';

class AuthWelcomeScreen extends StatelessWidget {
  const AuthWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAuthAppBar(),
            Text(
              'Welcome to',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: -0.64,
                fontFamily: 'Lexend',
              ),
            ),
            Image.asset(AssetsData.vZLogo),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: CustomButton(
                screenWidth: context.screenWidth,
                buttonTapHandler: () {
                  BlocProvider.of<AuthBottomSheetCubit>(
                    context,
                  ).changeBottomSheetState(pageRoute: kPhoneAuthScreenRoute);
                },
                buttonText: "Continue with Phone",
                btnTxtFontSize: 14,
                withIcon: true,
                icon: AssetsData.phone,
              ),
            ),
            CustomOrRowWidget(),
            Gaps.vGap8,
            Expanded(
              child: ListView.builder(
                itemCount: authTypes.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: CustomButton(
                      screenWidth: context.screenWidth,
                      buttonTapHandler: () {},
                      buttonText: "Continue with ${authTypes[index].title}",
                      buttonBackGroundColor: kGreyBtnColor,
                      textColor: kBlackTextColor,
                      btnTxtFontSize: 14,
                      borderColor: kGreyBtnColor,
                      withIcon: true,
                      icon: authTypes[index].iconPath,
                      //   withIcon: true,
                      // icon: AssetsData.google,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
