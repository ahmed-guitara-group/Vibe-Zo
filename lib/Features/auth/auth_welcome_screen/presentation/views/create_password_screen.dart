import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_zo/core/utils/helper.dart';
import 'package:vibe_zo/core/widgets/custom_text_field.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/gaps.dart';
import '../../../../../core/widgets/custom_auth_app_bar.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../manager/animation/animation_cubit.dart';
import '../manager/auth_bottom_sheet/auth_bottom_sheet_cubit.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({super.key});

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
              title: context.locale.translate("create_your_password")!,
              onBackButtonPressed: () {
                BlocProvider.of<AnimationCubit>(context).hideVerOtpField();
                BlocProvider.of<AuthBottomSheetCubit>(
                  context,
                ).changeBottomSheetState(
                  pageRoute: kVerifyPhoneNumberScreenRoute,
                );
              },
            ),
            Gaps.vGap30,

            CustomTextField(
              rowString: context.locale.translate("your_password")!,
              textInputType: TextInputType.number,
              obscureText: true,
              hintInTextField: "********",
            ),
            Gaps.vGap16,
            Row(
              children: [
                Icon(Icons.info_outline_rounded),
                Gaps.hGap8,
                Text(
                  context.locale.translate("password_requirements")!,
                  style: TextStyle(
                    color: const Color(0xFF384250),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.17,
                  ),
                ),
              ],
            ),
            Spacer(),
            CustomButton(
              screenWidth: context.screenWidth,
              buttonTapHandler: () {
                BlocProvider.of<AuthBottomSheetCubit>(
                  context,
                ).changeBottomSheetState(pageRoute: kLoginScreenRoute);
              },
              buttonText: context.locale.translate("continue")!,
              btnTxtFontSize: 14,
              withIcon: true,
              icon: AssetsData.continueIcon,
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
