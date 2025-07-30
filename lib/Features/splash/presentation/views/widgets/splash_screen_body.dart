import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vibe_zo/Features/splash/presentation/manger/validate_token/validate_token_cubit.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/constants.dart';

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
    //Validate token with login token and add data only
    BlocProvider.of<ValidateTokenCubit>(
      context,
    ).validateToken(token: Hive.box(kLoginTokenBox).get(kLoginTokenBox) ?? "");
    // if (Hive.box(kUserTokenBox).get(kUserTokenBox) != null) {
    //   BlocProvider.of<ValidateTokenCubit>(
    //     context,
    //   ).validateToken(token: Hive.box(kUserTokenBox).get(kUserTokenBox));
    // } else {
    //   Navigator.pushReplacementNamed(context, kAuthWelcomeScreenRoute);
    // }
    // Future.delayed(const Duration(seconds: 1), () {
    //   checkFirstSeen(context);
    // });
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
        // showModalBottomSheet(
        //   context: context,
        //   isScrollControlled: true,
        //   useSafeArea: true,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadiusGeometry.circular(20),
        //   ),
        //   isDismissible: false,
        //   enableDrag: false,
        //   backgroundColor: Colors.white,
        //   builder: (context) {
        //     return SizedBox();

        //     //  FractionallySizedBox(
        //     //   child: MultiBlocProvider(
        //     //     providers: [
        //     //       // BlocProvider(
        //     //       //   create: (context) => getIt<AuthBottomSheetCubit>(),
        //     //       // ),
        //     //       // BlocProvider(create: (context) => getIt<AnimationCubit>()),
        //     //       // BlocProvider(
        //     //       //   create: (context) => getIt<RegisterPhoneCubit>(),
        //     //       // ),
        //     //       // BlocProvider(create: (context) => getIt<SendCodeCubit>()),
        //     //       // BlocProvider(create: (context) => getIt<VerifyCodeCubit>()),
        //     //       // BlocProvider(
        //     //       //   create: (context) => getIt<CreatePasswordCubit>(),
        //     //       // ),
        //     //       // BlocProvider(create: (context) => getIt<SetupProfileUiCubit>()),
        //     //       // BlocProvider(create: (context) => getIt<GetCountriesCubit>()),
        //     //       // BlocProvider(create: (context) => getIt<GetLangsCubit>()),
        //     //     ],
        //     //     child: BlocBuilder<AuthBottomSheetCubit, AuthBottomSheetState>(
        //     //       builder: (context, state) {
        //     //         Widget child;
        //     //         // if (state is AuthBottomSheetChanged) {
        //     //         //   if (state.activePageRoute == kPhoneAuthScreenRoute) {
        //     //         //     child = const ContinueWithPhoneScreen();
        //     //         //   } else if (state.activePageRoute ==
        //     //         //       kVerifyPhoneNumberScreenRoute) {
        //     //         //     child = VerifyPhoneNumberScreen();
        //     //         //   } else if (state.activePageRoute ==
        //     //         //       kCreatePasswordScreenRoute) {
        //     //         //     child = const CreatePasswordScreen();
        //     //         //   } else if (state.activePageRoute == kLoginScreenRoute) {
        //     //         //     child = const LoginScreen();
        //     //         //   } else if (state.activePageRoute ==
        //     //         //       kSetupProfileScreenRoute) {
        //     //         //     child = SetupProfileScreen();
        //     //         //   } else if (state.activePageRoute ==
        //     //         //       kSetupProfileScreenStepOneRoute) {
        //     //         //     child = SetupProfileScreenStepOne();
        //     //         //   } else if (state.activePageRoute ==
        //     //         //       kSetupProfileScreenStepTwoRoute) {
        //     //         //     child = SetupProfileScreenStepTwo();
        //     //         //   } else {
        //     //         //     child = AuthWelcomeScreen();
        //     //         //   }
        //     //         // }

        //     //         child = AuthWelcomeScreen();

        //     //         return MediaQuery.removeViewInsets(
        //     //           removeBottom: true,
        //     //           context: context,
        //     //           child: child,
        //     //         );
        //     //       },
        //     //     ),
        //     //   ),
        //     // );
        //   },
        // );
      },
      child: BlocListener<ValidateTokenCubit, ValidateTokenState>(
        listener: (context, state) {
          if (state is ValidateTokenSuccessful) {
            Navigator.pushReplacementNamed(context, kBottomNavRoute);
          } else {
            Navigator.pushReplacementNamed(context, kAuthWelcomeScreenRoute);
          }
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

  // Future<void> checkFirstSeen(BuildContext context) async {
  //   // SharedPreferences pref = await SharedPreferences.getInstance();
  //   // bool seen = (pref.getBool('seen') ?? false);
  //   if (Hive.box(kUserTokenBox).get(kUserTokenBox) == null) {
  //     Navigator.pushReplacementNamed(context, kAuthWelcomeScreenRoute);

  //     // if (userDataBox.isNotEmpty) {
  //     //   Navigator.pushReplacementNamed(context, kBottomNavRoute);
  //     // } else {
  //     //   Navigator.pushReplacementNamed(context, kAuthWelcomeScreenRoute);
  //     // }
  //   } else {
  //     // await pref.setBool('seen', true);
  //     Navigator.pushReplacementNamed(context, kAuthWelcomeScreenRoute);

  //     // Navigator.pushReplacementNamed(context, kBottomNavRoute);
  //   }
  // }
}
