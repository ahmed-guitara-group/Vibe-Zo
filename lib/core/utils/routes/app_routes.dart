import 'package:flutter/material.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/views/auth_welcome_screen.dart';

import '../../../Features/Splash/presentation/views/splash_screen.dart';
import '../../../Features/auth/login/presentation/screens/login_screen.dart';
import '../../../Features/home/presentation/screens/home_screen.dart';
import '../../../Features/home/presentation/widgets/bottom_nav_widget.dart';
import '../../../Features/language/presentation/screens/language_screen.dart';
import '../constants.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case kLanguageScreenRoute:
        return MaterialPageRoute(builder: (_) => const LanguageScreen());
      case kHomeScreenRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case kAuthWelcomeScreenRoute:
        return MaterialPageRoute(builder: (_) => AuthWelcomeScreen());

      case kLoginScreenRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case kBottomNavRoute:
        return MaterialPageRoute(builder: (_) => const BottomNavWidget());

      case kProfileScreenRoute:
      default:
        return null;
    }
  }
}
