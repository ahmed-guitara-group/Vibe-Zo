import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/create_password/create_password_cubit.dart';
import 'package:vibe_zo/core/utils/functions/validation_mixin.dart';
import 'package:vibe_zo/core/utils/helper.dart';
import 'package:vibe_zo/core/widgets/custom_text_field.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/commons.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/gaps.dart';
import '../../../../../core/widgets/custom_auth_app_bar.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_loading_widget.dart';
import '../manager/animation/animation_cubit.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userTokenValue = Hive.box(kUserTokenBox).get(kUserTokenBox);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAuthAppBar(
                  hasArrowBackButton: true,
                  title: context.locale.translate("create_your_password")!,
                  onBackButtonPressed: () {
                    BlocProvider.of<AnimationCubit>(context).hideVerOtpField();
                    Navigator.pushNamed(context, kVerifyPhoneNumberScreenRoute);
                  },
                ),
                Gaps.vGap30,

                // Text field
                CustomTextField(
                  rowString: context.locale.translate("your_password")!,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: _passwordController,
                  validator: (password) => validatePassword(password),
                ),
                Gaps.vGap16,

                // Password requirements
                Row(
                  children: [
                    const Icon(Icons.info_outline_rounded),
                    Gaps.hGap8,
                    Text(
                      context.locale.translate("password_requirements")!,
                      style: const TextStyle(
                        color: Color(0xFF384250),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.17,
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                // Bloc Listener for success or error
                BlocListener<CreatePasswordCubit, CreatePasswordState>(
                  listener: (context, state) {
                    if (state is CreatePasswordSuccessful) {
                      Navigator.pop(context);
                      state.response.code == 'H10'
                          ? Navigator.pushNamedAndRemoveUntil(
                              context,
                              kBottomNavRoute,
                              (route) => false,
                            )
                          : Navigator.pushNamed(
                              context,
                              kSetupProfileScreenRoute,
                            );
                    } else if (state is CreatePasswordFailed) {
                      Commons.showToast(
                        context,
                        message: state.errorCode,
                        color: Colors.red,
                      );
                    }
                    if (state is CreatePasswordLoading) {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return CustomLoadiNgWidget();
                        },
                      );
                    }
                  },
                  child: CustomButton(
                    screenWidth: context.screenWidth,
                    buttonTapHandler: () {
                      FocusScope.of(context).unfocus();
                      final isValid =
                          _formKey.currentState?.validate() ?? false;
                      if (isValid) {
                        BlocProvider.of<CreatePasswordCubit>(
                          context,
                        ).createPassword(
                          userTokenValue,
                          _passwordController.text,
                        );
                      }
                    },
                    buttonText: context.locale.translate("continue")!,
                    btnTxtFontSize: 14,
                    withIcon: true,
                    icon: AssetsData.continueIcon,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
