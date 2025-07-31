import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/create_password/create_password_cubit.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/send_code/send_code_cubit.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/verify_code/verify_code_cubit.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/views/auth_welcome_screen.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/views/create_password_screen.dart';
import 'package:vibe_zo/Features/auth/setup_profile/presentation/manager/get_langs/get_langs_cubit.dart';
import 'package:vibe_zo/Features/splash/presentation/manger/validate_token/validate_token_cubit.dart';

import '../../../Features/Splash/presentation/views/splash_screen.dart';
import '../../../Features/auth/auth_welcome_screen/presentation/manager/animation/animation_cubit.dart';
import '../../../Features/auth/auth_welcome_screen/presentation/manager/register_phone/register_phone_cubit.dart';
import '../../../Features/auth/auth_welcome_screen/presentation/views/continue_with_phone_screen.dart';
import '../../../Features/auth/auth_welcome_screen/presentation/views/verify_phone_number_screen.dart';
import '../../../Features/auth/login/presentation/manager/login_cubit.dart';
import '../../../Features/auth/login/presentation/screens/login_screen.dart';
import '../../../Features/auth/setup_profile/presentation/manager/get_countries/get_countries_cubit.dart';
import '../../../Features/auth/setup_profile/presentation/manager/setup_profile/setup_profile_cubit.dart';
import '../../../Features/auth/setup_profile/presentation/manager/setup_profile_ui/setup_profile_cubit.dart';
import '../../../Features/auth/setup_profile/presentation/views/screens/setup_profile_screen.dart';
import '../../../Features/chat/presentation/manager/create_or_get_chat/create_or_get_chat_cubit.dart';
import '../../../Features/chat/presentation/manager/get_chat_messages/get_chat_messages_cubit.dart';
import '../../../Features/chat/presentation/views/chat_details_screen.dart';
import '../../../Features/home/presentation/manager/cubit/bottom_nav_cubit.dart';
import '../../../Features/home/presentation/screens/home_screen.dart';
import '../../../Features/home/presentation/widgets/bottom_nav_widget.dart';
import '../../../Features/language/presentation/screens/language_screen.dart';
import '../constants.dart';
import '../functions/setup_service_locator.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ValidateTokenCubit>(),
            child: const SplashScreen(),
          ),
        );
      case kLanguageScreenRoute:
        return MaterialPageRoute(builder: (_) => const LanguageScreen());
      case kHomeScreenRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case kAuthWelcomeScreenRoute:
        return MaterialPageRoute(builder: (_) => AuthWelcomeScreen());
      case kLoginScreenRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<LoginCubit>()),
              BlocProvider(create: (context) => getIt<AnimationCubit>()),
              BlocProvider(create: (context) => getIt<ValidateTokenCubit>()),
            ],
            child: const LoginScreen(),
          ),
        );
      case kBottomNavRoute:
        return MaterialPageRoute(
          builder: (_) => BlocBuilder<BottomNavCubit, BottomNavState>(
            builder: (context, state) {
              return const BottomNavWidget();
            },
          ),
        );
      case kPhoneAuthScreenRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<RegisterPhoneCubit>()),
              BlocProvider(create: (context) => getIt<AnimationCubit>()),
            ],
            child: const ContinueWithPhoneScreen(),
          ),
        );
      case kSetupProfileScreenRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<SetupProfileUiCubit>()),
              BlocProvider(create: (context) => getIt<GetLangsCubit>()),
              BlocProvider(create: (context) => getIt<AnimationCubit>()),
              BlocProvider(create: (context) => getIt<GetCountriesCubit>()),
              BlocProvider(create: (context) => getIt<SetupProfileCubit>()),
              BlocProvider(create: (context) => getIt<ValidateTokenCubit>()),
            ],
            child: const SetupProfileScreen(),
          ),
        );

      case kVerifyPhoneNumberScreenRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<AnimationCubit>()),
              BlocProvider(create: (context) => getIt<SendCodeCubit>()),
              BlocProvider(create: (context) => getIt<VerifyCodeCubit>()),
            ],
            child: const VerifyPhoneNumberScreen(),
          ),
        );

      case kCreatePasswordScreenRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<CreatePasswordCubit>()),
              BlocProvider(create: (context) => getIt<AnimationCubit>()),
            ],
            child: const CreatePasswordScreen(),
          ),
        );
      case kVerificationCodeScreenRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<SendCodeCubit>()),
              BlocProvider(create: (context) => getIt<VerifyCodeCubit>()),
              BlocProvider(create: (context) => getIt<AnimationCubit>()),
            ],
            child: const VerifyPhoneNumberScreen(),
          ),
        );
      case kChatDetailsScreenRoute:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<CreateOrGetChatCubit>()),
              BlocProvider(create: (context) => getIt<GetChatMessagesCubit>()),
            ],
            child: ChatDetailsScreen(toUserId: args as String),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
