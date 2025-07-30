import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vibe_zo/app.dart';

import 'Features/splash/domain/entity/login_entity.dart';
import 'core/utils/constants.dart';
import 'core/utils/functions/setup_service_locator.dart' as di;
import 'core/utils/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  await di.init();
  await Hive.initFlutter();
  Hive.registerAdapter(LoginEntityAdapter());

  //Auth Boxes
   await Hive.openBox<LoginEntity>(kUserDataBox);
  await Hive.openBox(kUserTokenBox);
  await Hive.openBox(kUserPhoneBox);
  await Hive.openBox(kSelectedMethodBox);
  await Hive.openBox(kLoginTokenBox);

  runApp(const VibeZo());
}
