// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
// import 'package:vibe_zo/core/utils/helper.dart';
// import 'package:vibe_zo/core/widgets/custom_text_field.dart';

// import '../../../../../core/utils/assets.dart';
// import '../../../../../core/utils/constants.dart';
// import '../../../../../core/utils/gaps.dart';
// import '../../../../../core/widgets/custom_auth_app_bar.dart';
// import '../../../../../core/widgets/custom_button.dart';
// import '../manager/auth_bottom_sheet/auth_bottom_sheet_cubit.dart';

// class VerificationCodeScreen extends StatelessWidget {
//   const VerificationCodeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomAuthAppBar(
//               hasArrowBackButton: true,
//               title: "Verify Your Phone Number",
//               onBackButtonPressed: () {
//                 BlocProvider.of<AuthBottomSheetCubit>(
//                   context,
//                 ).changeBottomSheetState(
//                   pageRoute: kVerifyPhoneNumberScreenRoute,
//                 );
//               },
//             ),
//             Gaps.vGap30,
//             RichText(
//               text: TextSpan(
//                 children: [
//                   WidgetSpan(
//                     alignment: PlaceholderAlignment.top,
//                     child: Transform.translate(
//                       offset: const Offset(0, -5),
//                       child: Text(
//                         '*',
//                         style: TextStyle(
//                           color: kRedTextColor,
//                           fontSize: 12,
//                           fontFamily: 'Lexend',
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const TextSpan(
//                     text: ' Phone Number',

//                     style: TextStyle(
//                       color: kBlackTextColor,
//                       fontSize: 12,
//                       fontFamily: 'Lexend',
//                       fontWeight: FontWeight.w400,
//                       height: 1.17,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             Gaps.vGap8,

//             IntlPhoneField(
//               flagsButtonPadding: EdgeInsetsGeometry.only(left: 8, right: 8),
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 14,
//                   horizontal: 12,
//                 ),
//                 hintText: '123 456 7890',
//                 hintStyle: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                   borderSide: const BorderSide(color: kGreyTextColor),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                   borderSide: const BorderSide(color: kGreyTextColor),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(6),
//                   borderSide: const BorderSide(color: kPrimaryColor),
//                 ),
//               ),
//               cursorColor: kPrimaryColor,
//               initialCountryCode: 'EG',
//               showDropdownIcon: true,

//               dropdownIconPosition: IconPosition.trailing,
//               dropdownIcon: const Icon(
//                 Icons.keyboard_arrow_down_rounded,
//                 color: kBlackTextColor,
//               ),
//               buildCounter:
//                   (
//                     context, {
//                     required currentLength,
//                     required isFocused,
//                     required maxLength,
//                   }) => null,
//               onChanged: (phone) {},
//             ),
//             SizedBox(height: 12),
//             CustomTextField(
//               maxLength: 6,
//               rowString: "Verification Code",
//               textInputType: TextInputType.number,
//               obscureText: false,
//               hintInTextField: "XXX XXX",
//             ),
//             Spacer(),
//             CustomButton(
//               screenWidth: context.screenWidth,
//               buttonTapHandler: () {
//                 BlocProvider.of<AuthBottomSheetCubit>(
//                   context,
//                 ).changeBottomSheetState(pageRoute: kCreatePasswordScreenRoute);
//               },
//               buttonText: "Continue",
//               btnTxtFontSize: 14,
//               withIcon: true,
//               icon: AssetsData.continueIcon,
//             ),
//             SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }
// }
