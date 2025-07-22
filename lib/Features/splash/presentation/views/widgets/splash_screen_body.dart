import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/auth_bottom_sheet/auth_bottom_sheet_cubit.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/views/auth_welcome_screen.dart';
import 'package:vibe_zo/core/utils/helper.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../auth/login/domain/entities/login_entity.dart';

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
        showBottomSheet(
          showDragHandle: false,
          enableDrag: false,
          constraints: BoxConstraints(maxHeight: context.screenHeight * .97),
          context: context,
          builder: (context) {
            return BlocBuilder<AuthBottomSheetCubit, AuthBottomSheetState>(
              builder: (context, state) {
                return AuthWelcomeScreen();
              },
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
