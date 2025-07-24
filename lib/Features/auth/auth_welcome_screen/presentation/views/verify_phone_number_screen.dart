import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:hive/hive.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/animation/animation_cubit.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/auth_bottom_sheet/auth_bottom_sheet_cubit.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/send_code/send_code_cubit.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/verify_code/verify_code_cubit.dart';
import 'package:vibe_zo/core/utils/helper.dart';
import 'package:vibe_zo/core/widgets/custom_loading_widget.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/gaps.dart';
import '../../../../../core/widgets/custom_auth_app_bar.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../widgets/custom_radio_btn.dart';

class VerifyPhoneNumberScreen extends StatefulWidget {
  const VerifyPhoneNumberScreen({super.key});

  @override
  State<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  bool _isButtonAtBottom = false;
  var userTokenValue = Hive.box(kUserTokenBox).get(kUserTokenBox) ?? '';
  var selectedMethodValue =
      Hive.box(kSelectedMethodBox).get(kSelectedMethodBox) ?? '';
  var userPhoneValue = Hive.box(kUserPhoneBox).get(kUserPhoneBox) ?? '';
  String? enteredCode;

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
  dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAuthAppBar(
              hasArrowBackButton: true,
              title: context.locale.translate("verify_your_phone_number")!,
              onBackButtonPressed: () {
                context.read<AuthBottomSheetCubit>().changeBottomSheetState(
                  pageRoute: kPhoneAuthScreenRoute,
                );
              },
            ),
            Gaps.vGap30,
            RichText(
              textAlign: TextAlign.start,
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
              enabled: false,
              initialValue: userPhoneValue,
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
                  }) {
                    return null;
                  },
              onChanged: (phone) {},
            ),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: BlocBuilder<AnimationCubit, AnimationState>(
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          axisAlignment: 0.0,
                          child: child,
                        ),
                      );
                    },
                    child: state is VerificationMethodSelected
                        ? CustomTextField(
                            key: const ValueKey('textField'),
                            maxLength: 6,
                            controller: _codeController,
                            rowString: context.locale.translate(
                              "verification_code",
                            )!,
                            textInputType: TextInputType.number,
                            obscureText: false,
                            hintInTextField: "XXX XXX",
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return " ";
                              } else if (value.trim().length != 6) {
                                return " ";
                              }
                              return null;
                            },
                            onChange: (p0) {
                              setState(() {
                                if (p0!.length == 6) {
                                  enteredCode = p0.trim();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                } else {
                                  enteredCode = null;
                                }
                              });
                            },
                          )
                        : const VerificationMethodSelector(
                            key: ValueKey('radioSelector'),
                          ),
                  );
                },
              ),
            ),
            const SizedBox(height: 6),
            const Spacer(),
            MultiBlocListener(
              listeners: [
                BlocListener<SendCodeCubit, SendCodeState>(
                  listener: (context, state) {
                    if (state is SendCodeSuccessful) {
                      context.read<AnimationCubit>().state
                              is VerificationMethodSelected
                          ? context
                                .read<AuthBottomSheetCubit>()
                                .changeBottomSheetState(
                                  pageRoute: kCreatePasswordScreenRoute,
                                )
                          : BlocProvider.of<AnimationCubit>(
                              context,
                            ).hideVerificationMethod();
                    } else if (state is SendCodeFailed) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(state.errorCode),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text("Ok"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
                BlocListener<VerifyCodeCubit, VerifyCodeState>(
                  listener: (context, state) {
                    if (state is VerifyCodeSuccessful) {
                      Navigator.pop(context);
                      context
                          .read<AuthBottomSheetCubit>()
                          .changeBottomSheetState(
                            pageRoute: kCreatePasswordScreenRoute,
                          );
                    } else if (state is VerifyCodeLoading) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [CustomLoadiNgWidget()],
                          );
                        },
                      );
                    } else if (state is VerifyCodeFailed) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Wrong Code"),
                          content: Text(state.errorCode),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text("Ok"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
              child: SizedBox(
                height: context.screenHeight * 0.3,
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                      alignment: _isButtonAtBottom
                          ? Alignment.bottomCenter
                          : Alignment.topCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BlocBuilder<SendCodeCubit, SendCodeState>(
                            builder: (context, state) {
                              return state is SendCodeLoading
                                  ? CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    )
                                  : CustomButton(
                                      screenWidth: context.screenWidth,
                                      buttonTapHandler: () {
                                        if (state is SendCodeSuccessful) {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (enteredCode != null) {
                                              if (state.response.code ==
                                                  "A12") {
                                                BlocProvider.of<
                                                      VerifyCodeCubit
                                                    >(context)
                                                    .verifyCode(
                                                      userTokenValue,
                                                      enteredCode!,
                                                    );
                                              }
                                            }
                                          }
                                        } else {
                                          if (userTokenValue != "" &&
                                              selectedMethodValue != "") {
                                            context
                                                .read<SendCodeCubit>()
                                                .sendCode(
                                                  userTokenValue,
                                                  selectedMethodValue,
                                                );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) => const Dialog(
                                                child: Text(
                                                  'Please select a verification method first',
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      buttonText: context.locale.translate(
                                        "continue",
                                      )!,
                                      btnTxtFontSize: 14,
                                      withIcon: true,
                                      icon: AssetsData.continueIcon,
                                    );
                            },
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
