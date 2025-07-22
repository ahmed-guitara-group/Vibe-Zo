import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart'
    show IntlPhoneField;
import 'package:vibe_zo/core/utils/gaps.dart';
import 'package:vibe_zo/core/utils/helper.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/custom_auth_app_bar.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../data/models/auth_type_model.dart';
import '../widgets/custom_or_row.dart';

class ContinueWithPhoneScreen extends StatefulWidget {
  const ContinueWithPhoneScreen({super.key});

  @override
  State<ContinueWithPhoneScreen> createState() =>
      _ContinueWithPhoneScreenState();
}

class _ContinueWithPhoneScreenState extends State<ContinueWithPhoneScreen> {
  bool moveButtonDown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        moveButtonDown = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * .07,
        child: const CustomAuthAppBar(
          title: "Continue With Phone",
          hasArrowBackButton: true,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              // SizedBox(height: context.screenHeight * 0.05),
              Text(
                'Phone Number',
                style: TextStyle(
                  color: const Color(0xFF161616) /* Form-field-text-label */,
                  fontSize: 12,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w400,
                  height: 1.17,
                ),
              ),
              Gaps.vGap8,
              IntlPhoneField(
                decoration: InputDecoration(
                  hintText: '123 456 7890',
                  //      labelStyle: TextStyle(color: Colors.black),
                  // Border when not focused
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kGreyTextColor),
                  ),
                  // Border when focused
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor, width: 2),
                  ),
                ),
                initialCountryCode: 'EG',
                onChanged: (phone) {},
              ),
              SizedBox(height: context.screenHeight * 0.1),

              SizedBox(
                height: context.screenHeight * 0.4,
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                      alignment: moveButtonDown
                          ? Alignment.bottomCenter
                          : Alignment.topCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomButton(
                            screenWidth: context.screenWidth,
                            buttonTapHandler: () {},
                            buttonText: "Continue",
                            btnTxtFontSize: 14,
                            withIcon: true,
                            icon: AssetsData.continueIcon,
                          ),
                          const SizedBox(height: 20),
                          const CustomOrRowWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Text(
                'Continue with Social Media',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF161616) /* Text-text-default */,
                  fontSize: 16,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w500,
                  height: 1.50,
                  letterSpacing: 0.50,
                ),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: authTypes.map((authType) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: kLightGreyTextColor,
                      child: IconButton(
                        icon: Image.asset(
                          authType.iconPath,
                          width: 24,
                          height: 24,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
