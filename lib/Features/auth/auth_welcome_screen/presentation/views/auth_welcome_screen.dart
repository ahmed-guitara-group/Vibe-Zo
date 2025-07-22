import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/assets.dart';
import 'package:vibe_zo/core/utils/gaps.dart';
import 'package:vibe_zo/core/utils/helper.dart';
import 'package:vibe_zo/core/widgets/custom_auth_app_bar.dart';
import 'package:vibe_zo/core/widgets/custom_button.dart';

import '../../../../../core/utils/constants.dart';
import '../../data/models/auth_type_model.dart';

class AuthWelcomeScreen extends StatelessWidget {
  const AuthWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AuthTypeModel> authTypes = [
      AuthTypeModel(title: 'Apple', iconPath: AssetsData.apple),
      AuthTypeModel(title: 'Google', iconPath: AssetsData.google),
      AuthTypeModel(title: 'Snapchat', iconPath: AssetsData.snapchat),
      AuthTypeModel(title: 'Facebook', iconPath: AssetsData.facebook),
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * .07,
        child: CustomAuthAppBar(),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                  buttonTapHandler: () {},
                  buttonText: "Continue with Phone",
                  btnTxtFontSize: 14,
                  withIcon: true,
                  icon: AssetsData.phone,
                ),
              ),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      color: kDividerColor,
                      thickness: 1.5,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    'Or',
                    style: TextStyle(
                      color: const Color(
                        0xFF6C727E,
                      ) /* Text-text-secondary-paragraph */,
                      fontSize: 32,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w500,
                      height: 1.25,
                      letterSpacing: -0.64,
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: kDividerColor,
                      thickness: 1.5,
                      indent: 10,
                    ),
                  ),
                ],
              ),
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
      ),
    );
  }
}
