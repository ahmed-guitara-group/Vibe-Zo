import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/presentation/manager/animation/animation_cubit.dart';

import '../../../Features/auth/auth_welcome_screen/data/data_source/register_phone_remote_data_source.dart';
import '../../../Features/auth/auth_welcome_screen/data/repo_impl/register_phone_repo_impl.dart';
import '../../../Features/auth/auth_welcome_screen/domain/repos/register_phone_repo.dart';
import '../../../Features/auth/auth_welcome_screen/domain/use_cases/register_phone_use_case.dart';
import '../../../Features/auth/auth_welcome_screen/presentation/manager/auth_bottom_sheet/auth_bottom_sheet_cubit.dart';
import '../../../Features/auth/auth_welcome_screen/presentation/manager/register_phone/register_phone_cubit.dart';
import '../../../Features/auth/login/data/data_sources/remote_data_source/login_remote_data_source.dart';
import '../../../Features/auth/login/data/repositories/login_repo_impl.dart';
import '../../../Features/auth/login/domain/repositories/login_repo.dart';
import '../../../Features/auth/login/domain/use_cases/login_use_case.dart';
import '../../../Features/auth/login/presentation/manager/login_cubit.dart';
import '../../../Features/home/presentation/manager/cubit/bottom_nav_cubit.dart';
import '../../../Features/splash/data/datasources/language_local_data_source.dart';
import '../../../Features/splash/data/datasources/language_local_data_source_impl.dart';
import '../../../Features/splash/data/repositories/language_repository_impl.dart';
import '../../../Features/splash/domain/repositories/language_repository.dart';
import '../../../Features/splash/domain/usecases/change_locale_use_case.dart';
import '../../../Features/splash/domain/usecases/get_saved_lang_use_case.dart';
import '../../../Features/splash/presentation/manger/locale_cubit/locale_cubit.dart';
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

  //Network
  getIt.registerLazySingleton<NetworkRequest>(() => NetworkRequestImp());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
}
