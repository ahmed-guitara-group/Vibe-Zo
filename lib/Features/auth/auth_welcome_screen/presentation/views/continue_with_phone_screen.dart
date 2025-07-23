import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/register_phone/register_phone_cubit.dart';
import 'package:vibe_zo/core/utils/gaps.dart';
import 'package:vibe_zo/core/utils/helper.dart';
import 'package:vibe_zo/core/widgets/custom_auth_app_bar.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../data/models/auth_type_model.dart';
import '../manager/auth_bottom_sheet/auth_bottom_sheet_cubit.dart';
import '../widgets/custom_or_row.dart';

class ContinueWithPhoneScreen extends StatefulWidget {
  const ContinueWithPhoneScreen({super.key});

  @override
  State<ContinueWithPhoneScreen> createState() =>
      _ContinueWithPhoneScreenState();
}

class _ContinueWithPhoneScreenState extends State<ContinueWithPhoneScreen> {
  bool _isButtonAtBottom = false;
  String _phoneNumber = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isButtonAtBottom = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            CustomAuthAppBar(
              hasArrowBackButton: true,
              title: "Continue With Phone",
              onBackButtonPressed: () {
                context.read<AuthBottomSheetCubit>().changeBottomSheetState(
                  pageRoute: kAuthWelcomeScreenRoute,
                );
              },
            ),
            Gaps.vGap30,
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.top,
                    child: Transform.translate(
                      offset: const Offset(0, -5),
                      child: Text(
                        '*',
                        style: TextStyle(
                          color: kRedTextColor,
                          fontSize: 12,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const TextSpan(
                    text: ' Phone Number',
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
            ),
            Gaps.vGap8,
            IntlPhoneField(
              flagsButtonPadding: const EdgeInsets.only(left: 8, right: 8),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 12,
                ),
                hintText: '123 456 7890',
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: kGreyTextColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: kGreyTextColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
              ),
              cursorColor: kPrimaryColor,
              initialCountryCode: 'EG',
              showDropdownIcon: true,
              dropdownIconPosition: IconPosition.trailing,
              dropdownIcon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: kBlackTextColor,
              ),
              buildCounter:
                  (
                    context, {
                    required currentLength,
                    required isFocused,
                    required maxLength,
                  }) => null,
              onChanged: (phone) {
                setState(() {
                  _phoneNumber = phone.completeNumber;
                });
              },
            ),
            SizedBox(height: context.screenHeight * 0.1),
            SizedBox(
              height: context.screenHeight * 0.4,
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                alignment: _isButtonAtBottom
                    ? Alignment.bottomCenter
                    : Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                      screenWidth: context.screenWidth,
                      buttonTapHandler: () async {
                        if (_phoneNumber.isEmpty) {
                        } else {}
                        await BlocProvider.of<RegisterPhoneCubit>(
                          context,
                        ).registerPhone("verified");
                      },
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
            ),
            const SizedBox(height: 16),
            const Text(
              'Continue with Social Media',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF161616),
                fontSize: 16,

                fontWeight: FontWeight.w500,
                height: 1.50,
                letterSpacing: 0.50,
              ),
            ),
            const SizedBox(height: 20),
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
    );
  }
}
