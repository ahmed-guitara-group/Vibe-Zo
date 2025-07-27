import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:hive/hive.dart';
import 'package:vibe_zo/Features/auth/setup_profile/presentation/manager/setup_profile/setup_profile_cubit.dart';
import 'package:vibe_zo/Features/auth/setup_profile/presentation/views/widgets/upload_image_widget.dart';
import 'package:vibe_zo/core/utils/commons.dart';
import 'package:vibe_zo/core/utils/constants.dart';
import 'package:vibe_zo/core/utils/gaps.dart';
import 'package:vibe_zo/core/utils/helper.dart';
import 'package:vibe_zo/core/widgets/custom_auth_app_bar.dart';
import 'package:vibe_zo/core/widgets/custom_button.dart';
import 'package:vibe_zo/core/widgets/custom_text_field.dart';

import '../../../../../../core/utils/functions/validation_mixin.dart';
import '../widgets/custom_gender_selector.dart';

class SetupProfileScreenStepOne extends StatefulWidget {
  const SetupProfileScreenStepOne({super.key});

  @override
  State<SetupProfileScreenStepOne> createState() =>
      _SetupProfileScreenStepOneState();
}

class _SetupProfileScreenStepOneState extends State<SetupProfileScreenStepOne>
    with ValidationMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _name;
  String? _idNumber;
  String? _birthDate;
  String? _gender;
  File? _pickedImage;

  final TextEditingController _birthDateController = TextEditingController();

  @override
  void dispose() {
    _birthDateController.dispose();
    super.dispose();
  }

  void _onGenderSelected(String gender) {
    _gender = gender;
  }

  void _onImagePicked(File image) {
    _pickedImage = image;
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate() &&
        _gender != null &&
        _pickedImage != null) {
      _formKey.currentState!.save();
      BlocProvider.of<SetupProfileCubit>(context).saveProfileData(
        name: _name!,
        idNumber: _idNumber!,
        gender: _gender!,
        birthDate: _birthDate!,
        image: _pickedImage,
      );
      BlocProvider.of<SetupProfileCubit>(context).changeStep(2);
    } else {
      if (_pickedImage == null || _gender == null) {
        Commons.showToast(
          context,
          message: "Please upload your profile image and select your gender",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var userPhoneValue = Hive.box(kUserPhoneBox).get(kUserPhoneBox) ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            CustomAuthAppBar(
              hasArrowBackButton: true,
              onBackButtonPressed: () => Navigator.pop(context),
              title: context.locale.translate("lets_setup_profile")!,
            ),
            const SizedBox(height: 24),

            ProfileImagePicker(initials: "AB", onImagePicked: _onImagePicked),
            const SizedBox(height: 24),

            GenderSelector(onGenderSelected: _onGenderSelected),
            const SizedBox(height: 36),

            CustomTextField(
              textInputType: TextInputType.name,
              obscureText: false,
              hintInTextField: "John Doe",
              rowString: "Your Name",
              validator: (val) => validateInputText(val),
              onChange: (val) => _name = val,
            ),
            const SizedBox(height: 8),

            CustomTextField(
              textInputType: TextInputType.name,
              obscureText: false,
              hintInTextField: "ID Number",
              rowString: "Your ID",
              validator: (val) => validateInputText(val),
              onChange: (val) => _idNumber = val,
            ),
            Gaps.vGap16,

            Row(
              children: [
                const Icon(Icons.info_outline_rounded),
                Gaps.hGap8,
                Text(
                  context.locale.translate("id_requirements")!,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            Gaps.vGap16,

            IntlPhoneField(
              enabled: false,
              initialValue: userPhoneValue,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 12,
                ),
                hintText: '123 456 7890',
                hintStyle: const TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: kGreyTextColor),
                ),
              ),
              initialCountryCode: 'EG',
              onChanged: (phone) {},
            ),
            const SizedBox(height: 24),

            InkWell(
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  final formattedDate =
                      "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                  setState(() {
                    _birthDate = formattedDate;
                    _birthDateController.text = formattedDate;
                  });
                }
              },
              child: CustomTextField(
                controller: _birthDateController,
                textInputType: TextInputType.none,
                obscureText: false,
                isRequired: false,
                enabled: false,
                hintInTextField: "DD/MM/YYYY",
                rowString: "Your Birthdate",
                validator: (val) => validateInputText(val),

                onChange: (val) {}, // لازم تكون موجودة حتى لو فاضية
              ),
            ),
            SizedBox(height: context.screenHeight * .04),

            CustomButton(
              screenWidth: context.screenWidth,
              buttonTapHandler: _onSubmit,
              buttonText: context.locale.translate("continue")!,
              btnTxtFontSize: 14,
              withIcon: true,
            ),
            SizedBox(height: context.screenHeight * .04),
          ],
        ),
      ),
    );
  }
}
