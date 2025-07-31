import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vibe_zo/Features/splash/domain/entity/login_entity.dart';
import 'package:vibe_zo/core/utils/constants.dart';
import 'package:vibe_zo/core/utils/network/api/network_api.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userData = Hive.box<LoginEntity>(kUserDataBox);

    return Column(
      children: [
        ElevatedButton(
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
        ),
        Text(userData.getAt(0)!.name),
        Text(userData.getAt(0)!.id.toString()),

        Text(userData.getAt(0)!.username),

        Text(userData.getAt(0)!.phone),
        Image.network(
          "${Api.baseImageUrl}${userData.getAt(0)!.profileImageName}",
          width: 200,
          height: 200,
        ),
      ],
    );
  }
}
