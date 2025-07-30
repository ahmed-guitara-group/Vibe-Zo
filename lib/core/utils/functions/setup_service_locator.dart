import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/animation/animation_cubit.dart';
import 'package:vibe_zo/Features/auth/setup_profile/presentation/manager/get_langs/get_langs_cubit.dart';

import '../../../Features/auth/auth_welcome_screen/data/data_source/register_phone_remote_data_source.dart';
import '../../../Features/auth/auth_welcome_screen/data/repo_impl/register_phone_repo_impl.dart';
import '../../../Features/auth/auth_welcome_screen/domain/repos/register_phone_repo.dart';
import '../../../Features/auth/auth_welcome_screen/domain/use_cases/create_password_use_case.dart';
import '../../../Features/auth/auth_welcome_screen/domain/use_cases/register_phone_use_case.dart';
import '../../../Features/auth/auth_welcome_screen/domain/use_cases/send_code_use_case.dart';
import '../../../Features/auth/auth_welcome_screen/domain/use_cases/verify_code_use_case.dart';
import '../../../Features/auth/auth_welcome_screen/presentation/manager/auth_bottom_sheet/auth_bottom_sheet_cubit.dart';
import '../../../Features/auth/auth_welcome_screen/presentation/manager/create_password/create_password_cubit.dart';
import '../../../Features/auth/auth_welcome_screen/presentation/manager/register_phone/register_phone_cubit.dart';
import '../../../Features/auth/auth_welcome_screen/presentation/manager/send_code/send_code_cubit.dart';
import '../../../Features/auth/auth_welcome_screen/presentation/manager/verify_code/verify_code_cubit.dart';
import '../../../Features/auth/login/data/data_sources/remote_data_source/login_remote_data_source.dart';
import '../../../Features/auth/login/data/repositories/login_repo_impl.dart';
import '../../../Features/auth/login/domain/repositories/login_repo.dart';
import '../../../Features/auth/login/domain/use_cases/login_use_case.dart';
import '../../../Features/auth/login/presentation/manager/login_cubit.dart';
import '../../../Features/auth/setup_profile/data/data_source/countries_remote_data_source.dart';
import '../../../Features/auth/setup_profile/data/data_source/setup_profile_remote_data_source.dart';
import '../../../Features/auth/setup_profile/data/repos/countries_repo_impl.dart';
import '../../../Features/auth/setup_profile/data/repos/setup_profile_repo_impl.dart';
import '../../../Features/auth/setup_profile/domain/repos/countries_repo.dart';
import '../../../Features/auth/setup_profile/domain/repos/setup_profile_repo.dart';
import '../../../Features/auth/setup_profile/domain/use_cases/get_countries_use_case.dart';
import '../../../Features/auth/setup_profile/domain/use_cases/setup_profile_use_case.dart';
import '../../../Features/auth/setup_profile/presentation/manager/get_countries/get_countries_cubit.dart';
import '../../../Features/auth/setup_profile/presentation/manager/setup_profile/setup_profile_cubit.dart';
import '../../../Features/auth/setup_profile/presentation/manager/setup_profile_ui/setup_profile_cubit.dart';
import '../../../Features/chat/data/remote_data_source.dart/get_all_chats_remote_data_source.dart';
import '../../../Features/chat/data/repos_impl/get_all_chats_repo_impl.dart';
import '../../../Features/chat/domain/repos/get_all_chat_repo.dart';
import '../../../Features/chat/domain/use_cases/create_or_get_chat_use_case.dart';
import '../../../Features/chat/domain/use_cases/get_all_chats_use_case.dart';
import '../../../Features/chat/presentation/manager/create_or_get_chat/create_or_get_chat_cubit.dart';
import '../../../Features/chat/presentation/manager/get_all_chats/get_all_chats_cubit.dart';
import '../../../Features/home/presentation/manager/cubit/bottom_nav_cubit.dart';
import '../../../Features/splash/data/datasources/language_local_data_source.dart';
import '../../../Features/splash/data/datasources/language_local_data_source_impl.dart';
import '../../../Features/splash/data/datasources/validate_token_remote_data_source.dart';
import '../../../Features/splash/data/repositories/language_repository_impl.dart';
import '../../../Features/splash/data/repositories/validate_token_repo_impl.dart';
import '../../../Features/splash/domain/repositories/language_repository.dart';
import '../../../Features/splash/domain/repositories/validate_token_repo.dart';
import '../../../Features/splash/domain/usecases/change_locale_use_case.dart';
import '../../../Features/splash/domain/usecases/get_saved_lang_use_case.dart';
import '../../../Features/splash/domain/usecases/validate_token_use_case.dart';
import '../../../Features/splash/presentation/manger/locale_cubit/locale_cubit.dart';
import '../../../Features/splash/presentation/manger/validate_token/validate_token_cubit.dart';
import '../api_service.dart';
import '../network/network_request.dart';

final getIt = GetIt.instance;
Future<void> init() async {
  getIt.registerLazySingleton<LanguageLocalDataSource>(
    () => LanguageLocalDataSourceImpl(sharedPreferences: getIt()),
  );
  getIt.registerSingleton<ApiService>(ApiService(Dio()));

  getIt.registerFactory<LocaleCubit>(
    () => LocaleCubit(
      changeLocaleUseCase: getIt.call(),
      getSavedLangUseCase: getIt.call(),
    ),
  );

  getIt.registerLazySingleton<GetSavedLangUseCase>(
    () => GetSavedLangUseCase(languageRepository: getIt.call()),
  );
  getIt.registerLazySingleton<ChangeLocaleUseCase>(
    () => ChangeLocaleUseCase(languageRepository: getIt.call()),
  );

  getIt.registerLazySingleton<LanguageRepository>(
    () => LanguageRepositoryImpl(languageLocalDataSource: getIt.call()),
  );

  //BottomNavCubit
  getIt.registerFactory<BottomNavCubit>(() => BottomNavCubit());

  // AuthBottomSheetCubit
  getIt.registerFactory<AuthBottomSheetCubit>(() => AuthBottomSheetCubit());
  getIt.registerFactory<AnimationCubit>(() => AnimationCubit());

  //LoginCubit
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt.call()));
  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt.call()));
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepoImpl(getIt.call()));
  getIt.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(),
  );
  //register phone
  getIt.registerFactory<RegisterPhoneCubit>(
    () => RegisterPhoneCubit(getIt.call()),
  );
  getIt.registerLazySingleton<RegisterPhoneUseCase>(
    () => RegisterPhoneUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<RegisterPhoneRepo>(
    () => RegisterPhoneRepoImpl(getIt.call()),
  );
  getIt.registerLazySingleton<RegisterPhoneRemoteDataSource>(
    () => RegisterPhoneRemoteDataSourceImpl(),
  );
  // Send Code
  getIt.registerFactory<SendCodeCubit>(() => SendCodeCubit(getIt.call()));
  getIt.registerLazySingleton<SendCodeUseCase>(
    () => SendCodeUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<SendCodeRepo>(
    () => SendCodeRepoImpl(getIt.call()),
  );
  getIt.registerLazySingleton<SendCodeRemoteDataSource>(
    () => SendCodeRemoteDataSourceImpl(),
  );
  //Verify Code
  getIt.registerFactory<VerifyCodeCubit>(() => VerifyCodeCubit(getIt.call()));
  getIt.registerLazySingleton<VerifyCodeUseCase>(
    () => VerifyCodeUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<VerifyCodeRepo>(
    () => VerifyCodeRepoImpl(getIt.call()),
  );
  getIt.registerLazySingleton<VerifyCodeRemoteDataSource>(
    () => VerifyCodeRemoteDataSourceImpl(),
  );
  //Create Password
  getIt.registerFactory<CreatePasswordCubit>(
    () => CreatePasswordCubit(getIt.call()),
  );
  getIt.registerLazySingleton<CreatePasswordUseCase>(
    () => CreatePasswordUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<CreatePasswordRepo>(
    () => CreatePasswordRepoImpl(getIt.call()),
  );
  getIt.registerLazySingleton<CreatePasswordRemoteDataSource>(
    () => CreatePasswordRemoteDataSourceImpl(),
  );
  // Setup Profile - Get Countries - Get Langs
  getIt.registerFactory<SetupProfileUiCubit>(() => SetupProfileUiCubit());
  getIt.registerFactory<GetCountriesCubit>(
    () => GetCountriesCubit(getIt.call()),
  );
  getIt.registerFactory<GetLangsCubit>(() => GetLangsCubit(getIt.call()));
  getIt.registerLazySingleton<GetCountriesUseCase>(
    () => GetCountriesUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<GetCountriesRepo>(
    () => CountriesRepoImpl(getIt.call()),
  );
  getIt.registerLazySingleton<GetCountriesRemoteDataSource>(
    () => GetCountriesRemoteDataSourceImpl(),
  );
  //Setup Profile
  getIt.registerFactory<SetupProfileCubit>(
    () => SetupProfileCubit(getIt.call()),
  );
  getIt.registerLazySingleton<SetupProfileUseCase>(
    () => SetupProfileUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<SetupProfileRepo>(
    () => SetupProfileRepoImpl(getIt.call()),
  );
  getIt.registerLazySingleton<SetupProfileRemoteDataSource>(
    () => SetupProfileRemoteDataSourceImpl(),
  );
  //Validate token
  getIt.registerFactory<ValidateTokenCubit>(
    () => ValidateTokenCubit(getIt.call()),
  );
  getIt.registerLazySingleton<ValidateTokenUseCase>(
    () => ValidateTokenUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<ValidateTokenRepo>(
    () => ValidateTokenRepoImpl(getIt.call()),
  );
  getIt.registerLazySingleton<ValidateTokenRemoteDataSource>(
    () => ValidateTokenRemoteDataSourceImpl(),
  );
  // GetAllChats
  getIt.registerFactory<GetAllChatsCubit>(() => GetAllChatsCubit(getIt.call()));
  getIt.registerLazySingleton<GetAllChatsUseCase>(
    () => GetAllChatsUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<GetAllChatsRepo>(
    () => GetAllChatsRepoImpl(getIt.call()),
  );
  getIt.registerLazySingleton<GetAllChatsRemoteDataSource>(
    () => GetAllChatsRemoteDataSourceImpl(),
  );

  // CreateOrGetChat
  getIt.registerFactory<CreateOrGetChatCubit>(() => CreateOrGetChatCubit(getIt.call()));
  getIt.registerLazySingleton<CreateOrGetChatUseCase>(
    () => CreateOrGetChatUseCase(getIt.call()),
  );
  getIt.registerLazySingleton<CreateOrGetChatRepo>(
    () => CreateOrGetChatRepoImpl(getIt.call()),
  );
  getIt.registerLazySingleton<CreateOrGetChatRemoteDataSource>(
    () => CreateOrGetChatRemoteDataSourceImpl(),
  );
  //Network
  getIt.registerLazySingleton<NetworkRequest>(() => NetworkRequestImp());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
}
