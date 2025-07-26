import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:hive/hive.dart';
import 'package:vibe_zo/Features/auth/setup_profile/presentation/views/widgets/upload_image_widget.dart';
import 'package:vibe_zo/core/utils/helper.dart';
import 'package:vibe_zo/core/widgets/custom_auth_app_bar.dart';
import 'package:vibe_zo/core/widgets/custom_button.dart';
import 'package:vibe_zo/core/widgets/custom_text_field.dart';

import '../../../../../../core/utils/constants.dart';
import '../../../../../../core/utils/gaps.dart';
import '../../../../auth_welcome_screen/presentation/manager/auth_bottom_sheet/auth_bottom_sheet_cubit.dart';

class SetupProfileScreenStepOne extends StatelessWidget {
  const SetupProfileScreenStepOne({super.key});

  @override
  Widget build(BuildContext context) {
    var userPhoneValue = Hive.box(kUserPhoneBox).get(kUserPhoneBox) ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          CustomAuthAppBar(
            title: context.locale.translate("lets_setup_profile")!,
          ),
          SizedBox(height: 24),
          ProfileImagePicker(initials: "AB", onTap: () {}),
          SizedBox(height: 24),
          GenderSelector(),
          SizedBox(height: 36),

          CustomTextField(
            textInputType: TextInputType.name,
            obscureText: false,
            hintInTextField: "John Doe",
            rowString: "Your Name",
          ),
          SizedBox(height: 8),
          CustomTextField(
            textInputType: TextInputType.name,
            obscureText: false,
            hintInTextField: "ID Number",
            rowString: "Your ID",
          ),
          Gaps.vGap16,

          Row(
            children: [
              const Icon(Icons.info_outline_rounded),
              Gaps.hGap8,
              Text(
                context.locale.translate("id_requirements")!,
                style: const TextStyle(
                  color: Color(0xFF384250),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.17,
                ),
              ),
            ],
          ),
          Gaps.vGap16,
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
          SizedBox(height: 24),

          CustomTextField(
            textInputType: TextInputType.name,
            obscureText: false,
            isRequired: false,
            onChange: (p0) {},
            // initialValue: "",
            hintInTextField: "DD/MM/YYYY",
            rowString: "Your Birthdate",
          ),
          SizedBox(height: context.screenHeight * .04),

          CustomButton(
            screenWidth: context.screenWidth,
            buttonTapHandler: () {
              //mOVE TO THE NEXT PAGE
              BlocProvider.of<AuthBottomSheetCubit>(
                context,
              ).changeBottomSheetState(
                pageRoute: kSetupProfileScreenStepTwoRoute,
              );
            },
            buttonText: context.locale.translate("continue")!,
            btnTxtFontSize: 14,
            withIcon: true,
            //  icon: AssetsData.continueIcon,
          ),
        ],
      ),
    );
  }
}
