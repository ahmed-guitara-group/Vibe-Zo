import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vibe_zo/Features/splash/domain/entity/login_entity.dart';
import 'package:vibe_zo/core/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        //clear all local storage and go to welcomeAuthScreen
        await Hive.box<LoginEntity>(kUserDataBox).clear();
        await Hive.box(kUserTokenBox).clear();
        await Hive.box(kUserPhoneBox).clear();
        await Hive.box(kSelectedMethodBox).clear();
        await Hive.box(kLoginTokenBox).clear();

        Navigator.pushNamedAndRemoveUntil(
          context,
          kAuthWelcomeScreenRoute,
          (route) => false,
        );
      },
      child: const Text("Log out"),
    );
  }
}
