import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/auth_bottom_sheet/auth_bottom_sheet_cubit.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/create_password/create_password_cubit.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/register_phone/register_phone_cubit.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/verify_code/verify_code_cubit.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/views/auth_welcome_screen.dart';
import 'package:vibe_zo/Features/auth/setup_profile/presentation/manager/get_langs/get_langs_cubit.dart';
import 'package:vibe_zo/core/utils/functions/setup_service_locator.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../auth/auth_welcome_screen/presentation/manager/animation/animation_cubit.dart';
import '../../../../auth/auth_welcome_screen/presentation/manager/send_code/send_code_cubit.dart';
import '../../../../auth/setup_profile/presentation/manager/get_countries/get_countries_cubit.dart';
import '../../../../auth/setup_profile/presentation/manager/setup_profile/setup_profile_cubit.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  // var userDataBox = Hive.box<LoginEntity>(kUserDataBox);
  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    Future.delayed(const Duration(hours: 3), () {
      checkFirstSeen(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20),
          ),
          isDismissible: false,
          enableDrag: false,
          backgroundColor: Colors.white,
          builder: (context) {
            return FractionallySizedBox(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => getIt<AuthBottomSheetCubit>(),
                  ),
                  BlocProvider(create: (context) => getIt<AnimationCubit>()),
                  BlocProvider(
                    create: (context) => getIt<RegisterPhoneCubit>(),
                  ),
                  BlocProvider(create: (context) => getIt<SendCodeCubit>()),
                  BlocProvider(create: (context) => getIt<VerifyCodeCubit>()),
                  BlocProvider(
                    create: (context) => getIt<CreatePasswordCubit>(),
                  ),
                  BlocProvider(create: (context) => getIt<SetupProfileCubit>()),
                  BlocProvider(create: (context) => getIt<GetCountriesCubit>()),
                  BlocProvider(create: (context) => getIt<GetLangsCubit>()),
                ],
                child: BlocBuilder<AuthBottomSheetCubit, AuthBottomSheetState>(
                  builder: (context, state) {
                    Widget child;
                    // if (state is AuthBottomSheetChanged) {
                    //   if (state.activePageRoute == kPhoneAuthScreenRoute) {
                    //     child = const ContinueWithPhoneScreen();
                    //   } else if (state.activePageRoute ==
                    //       kVerifyPhoneNumberScreenRoute) {
                    //     child = VerifyPhoneNumberScreen();
                    //   } else if (state.activePageRoute ==
                    //       kCreatePasswordScreenRoute) {
                    //     child = const CreatePasswordScreen();
                    //   } else if (state.activePageRoute == kLoginScreenRoute) {
                    //     child = const LoginScreen();
                    //   } else if (state.activePageRoute ==
                    //       kSetupProfileScreenRoute) {
                    //     child = SetupProfileScreen();
                    //   } else if (state.activePageRoute ==
                    //       kSetupProfileScreenStepOneRoute) {
                    //     child = SetupProfileScreenStepOne();
                    //   } else if (state.activePageRoute ==
                    //       kSetupProfileScreenStepTwoRoute) {
                    //     child = SetupProfileScreenStepTwo();
                    //   } else {
                    //     child = AuthWelcomeScreen();
                    //   }
                    // }

                    child = AuthWelcomeScreen();

                    return MediaQuery.removeViewInsets(
                      removeBottom: true,
                      context: context,
                      child: child,
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: ZoomIn(child: Image.asset(AssetsData.vZLogo)),
          ),
        ],
      ),
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(animationController);

    animationController.forward();
  }

  Future<void> checkFirstSeen(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool seen = (pref.getBool('seen') ?? false);
    if (seen) {
      Navigator.pushReplacementNamed(context, kAuthWelcomeScreenRoute);

      // if (userDataBox.isNotEmpty) {
      //   Navigator.pushReplacementNamed(context, kBottomNavRoute);
      // } else {
      //   Navigator.pushReplacementNamed(context, kAuthWelcomeScreenRoute);
      // }
    } else {
      await pref.setBool('seen', true);
      Navigator.pushReplacementNamed(context, kAuthWelcomeScreenRoute);
    }
  }
}
