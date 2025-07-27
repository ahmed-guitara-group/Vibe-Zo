import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/data/models/send_code_model/send_code_model.dart';

import '../../../domain/use_cases/setup_profile_use_case.dart';

part 'setup_profile_state.dart';

class SetupProfileCubit extends Cubit<SetupProfileState> {
  SetupProfileUseCase setupProfileUseCase;
  SetupProfileCubit(this.setupProfileUseCase) : super(SetupProfileInitial());
  Future<void> setupProfile({
    required String userName,
    required String name,
    required String birthDate,
    required String gender,
    required List<String> spokenLanguages,
    required List<String> countries,
    required File photo,
    required String token,
  }) async {
    emit(SetupProfileLoading());
    final result = await setupProfileUseCase.call(
      birthDate: birthDate,
      countries: countries,
      gender: gender,
      name: name,
      photo: photo,
      spokenLanguages: spokenLanguages,
      token: token,
      userName: userName,
    );

    emit(result.fold(SetupProfileFailed.new, SetupProfileSuccessful.new));
  }
}
