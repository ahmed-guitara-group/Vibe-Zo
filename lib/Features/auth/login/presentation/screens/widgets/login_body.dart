import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:hive/hive.dart';
import 'package:vibe_zo/core/utils/helper.dart';
import 'package:vibe_zo/core/widgets/custom_auth_app_bar.dart'
    show CustomAuthAppBar;

import '../../../../../../core/utils/assets.dart';
import '../../../../../../core/utils/commons.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../../../core/utils/functions/validation_mixin.dart';
import '../../../../../../core/utils/gaps.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../auth_welcome_screen/data/models/auth_type_model.dart';
import '../../../../auth_welcome_screen/presentation/manager/auth_bottom_sheet/auth_bottom_sheet_cubit.dart';
import '../../../../auth_welcome_screen/presentation/widgets/custom_or_row.dart';
import '../../../domain/entities/login_entity.dart';
import '../../manager/login_cubit.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> with ValidationMixin {
  final phoneController = TextEditingController();
  final passWordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var userDataBox = Hive.box<LoginEntity>(kUserDataBox);

    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) async {
            if (state is LoginSuccessful) {
              Commons.showToast(
                context,
                message: 'Success',
                color: Colors.green,
              );
              //Save user data in hive
              await userDataBox.clear();
              await userDataBox.add(state.user);
              Navigator.pushReplacementNamed(context, kBottomNavRoute);
              // var user = userDataBox.getAt(0);
              // print(user!.createdAt);
            }
            if (state is LoginFailed) {
              Commons.showToast(
                context,
                message: state.message,
                color: Colors.red,
              );
            }
          },
        ),
      ],

      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              CustomAuthAppBar(
                hasArrowBackButton: true,
                title: "Login to your account",
                onBackButtonPressed: () {
                  BlocProvider.of<AuthBottomSheetCubit>(
                    context,
                  ).changeBottomSheetState(pageRoute: kAuthWelcomeScreenRoute);
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
                flagsButtonPadding: EdgeInsetsGeometry.only(left: 8, right: 8),
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
                onChanged: (phone) {},
              ),
              Gaps.vGap12,
              CustomTextField(
                // maxLength: 6,
                rowString: "Your Password",
                textInputType: TextInputType.number,
                obscureText: true,
                hintInTextField: "********",
              ),
              SizedBox(height: context.screenHeight * .2),
              CustomButton(
                screenWidth: context.screenWidth,
                buttonTapHandler: () {},
                buttonText: "Continue",
                btnTxtFontSize: 14,
                withIcon: true,
                icon: AssetsData.continueIcon,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 21),
                  child: Text(
                    'Forget your password?',
                    style: TextStyle(
                      color: kBlackTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.29,
                    ),
                  ),
                ),
              ),
              CustomOrRowWidget(),

              const SizedBox(height: 16),
              Text(
                'Continue with Social Media',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF161616),
                  fontSize: 16,
                  fontFamily: 'Lexend',
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
      ),
    );
  }
}
