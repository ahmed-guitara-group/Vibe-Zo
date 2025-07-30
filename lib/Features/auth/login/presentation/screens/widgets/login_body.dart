import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:hive/hive.dart';
import 'package:vibe_zo/core/utils/helper.dart';
import 'package:vibe_zo/core/widgets/custom_alert_dialog.dart';
import 'package:vibe_zo/core/widgets/custom_auth_app_bar.dart'
    show CustomAuthAppBar;
import 'package:vibe_zo/core/widgets/custom_loading_widget.dart';

import '../../../../../../core/utils/assets.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../core/utils/functions/validation_mixin.dart';
import '../../../../../../core/utils/gaps.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../manager/login_cubit.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> with ValidationMixin {
  String phoneNumberValue = Hive.box(kUserPhoneBox).get(kUserPhoneBox) ?? '';
  String tokenValue = Hive.box(kUserTokenBox).get(kUserTokenBox) ?? '';

  @override
  Widget build(BuildContext context) {
    final passWordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) async {
            if (state is LoginSuccessful) {
              //Save token to hive box
              await Hive.box(kLoginTokenBox).clear();

              await Hive.box(
                kLoginTokenBox,
              ).put(kLoginTokenBox, state.user.data!.token!.token);
              // Hide loading dialog
              Navigator.pop(context);
              // if code H10 Go to home screen
              // if code A15 Go to Setup profile screen
              if (state.user.code == 'H10') {
                await Hive.box(kUserTokenBox).clear();
                await Hive.box(
                  kUserTokenBox,
                ).put(kUserTokenBox, state.user.data!.token!.token);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  kBottomNavRoute,
                  (route) => false,
                );
              } else if (state.user.code == 'A15') {
                Navigator.pushNamed(context, kSetupProfileScreenRoute);
              } else {}
            }
            if (state is LoginFailed) {
              // Hide loading dialog
              Navigator.pop(context);
              // Show Error dialog
              showDialog(
                context: context,
                builder: (context) {
                  return CustomAlertDialog(title: state.message);
                },
              );
            }
            if (state is LoginLoading) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => CustomLoadiNgWidget(),
              );
            }
          },
        ),
      ],
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CustomAuthAppBar(
                  hasArrowBackButton: true,
                  title: context.locale.translate("login_to_your_account")!,
                  onBackButtonPressed: () {
                    Navigator.pop(context);
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
                            '* ',
                            style: TextStyle(
                              color: kRedTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: context.locale.translate("phone_number")!,
                        style: TextStyle(
                          color: kBlackTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.17,
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.vGap8,
                IntlPhoneField(
                  enabled: false,
                  buildCounter:
                      (
                        context, {
                        required currentLength,
                        required isFocused,
                        required maxLength,
                      }) => null,
                  initialValue: phoneNumberValue,
                  //  controller: phoneController,
                  flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 8),
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
                ),
                Gaps.vGap12,
                CustomTextField(
                  controller: passWordController,
                  rowString: context.locale.translate("your_password")!,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  hintInTextField: "********",
                  validator: (value) => validatePassword(value!),
                ),
                SizedBox(height: context.screenHeight * .2),
                CustomButton(
                  screenWidth: context.screenWidth,
                  buttonTapHandler: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<LoginCubit>(context).login(
                        password: passWordController.text,
                        phone: phoneNumberValue,
                        token: tokenValue,
                      );
                    }
                  },
                  buttonText: context.locale.translate("continue")!,
                  btnTxtFontSize: 14,
                  withIcon: true,
                  icon: AssetsData.continueIcon,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, kVerificationCodeScreenRoute);
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 21),
                      child: Text(
                        context.locale.translate("forgot_password")!,
                        style: TextStyle(
                          color: kBlackTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.29,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
