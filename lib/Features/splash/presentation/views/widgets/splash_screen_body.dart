import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/auth_bottom_sheet/auth_bottom_sheet_cubit.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/views/auth_welcome_screen.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/views/continue_with_phone_screen.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/views/verify_phone_number_screen.dart';
import 'package:vibe_zo/core/utils/functions/setup_service_locator.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../auth/auth_welcome_screen/presentation/manager/animation/animation_cubit.dart';
import '../../../../auth/auth_welcome_screen/presentation/views/create_password_screen.dart';
import '../../../../auth/login/domain/entities/login_entity.dart';
import '../../../../auth/login/presentation/screens/login_screen.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  var userDataBox = Hive.box<LoginEntity>(kUserDataBox);
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
                ],
                child: BlocBuilder<AuthBottomSheetCubit, AuthBottomSheetState>(
                  builder: (context, state) {
                    Widget child;

                    if (state is AuthBottomSheetChanged) {
                      if (state.activePageRoute == kPhoneAuthScreenRoute) {
                        child = const ContinueWithPhoneScreen();
                      } else if (state.activePageRoute ==
                          kVerifyPhoneNumberScreenRoute) {
                        child = VerifyPhoneNumberScreen();
                      }
                      // else if (state.activePageRoute ==
                      //     kVerificationCodeScreenRoute) {
                      //   child = const VerificationCodeScreen();
                      // }
                      else if (state.activePageRoute ==
                          kCreatePasswordScreenRoute) {
                        child = const CreatePasswordScreen();
                      } else if (state.activePageRoute == kLoginScreenRoute) {
                        child = const LoginScreen();
                      } else {
                        child = AuthWelcomeScreen();
                      }
                    } else {
                      child = AuthWelcomeScreen();
                    }

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
      if (userDataBox.isNotEmpty) {
        Navigator.pushReplacementNamed(context, kBottomNavRoute);
      } else {
        Navigator.pushReplacementNamed(context, kAuthWelcomeScreenRoute);
      }
    } else {
      await pref.setBool('seen', true);
      Navigator.pushReplacementNamed(context, kLanguageScreenRoute);
    }
  }
}
