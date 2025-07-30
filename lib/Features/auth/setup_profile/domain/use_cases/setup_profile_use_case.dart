import 'dart:io';

import '../../data/data_source/setup_profile_remote_data_source.dart';
import '../../data/models/languages_model/languages_model.dart';
import '../../data/models/setup_profile_model/setup_profile_model.dart';
import '../repos/setup_profile_repo.dart';

abstract class UseCase<type> {
  Future<SetupProfileResponse> call({
    required String userName,
    required String name,
    required String birthDate,
    required String gender,
    required List<String> spokenLanguages,
    required List<String> countries,
    required File photo,
    required String token,
  });
}

class SetupProfileUseCase extends UseCase<SetupProfileModel> {
  final SetupProfileRepo setupProfileRepo;
  SetupProfileUseCase(this.setupProfileRepo);

  @override
  Future<SetupProfileResponse> call({
    required String userName,
    required String name,
    required String birthDate,
    required String gender,
    required List<String> spokenLanguages,
    required List<String> countries,
    required File photo,
    required String token,
  }) async {
    return await setupProfileRepo.setupProfile(
      birthDate: birthDate,
      countries: countries,
      gender: gender,
      name: name,
      photo: photo,
      spokenLanguages: spokenLanguages,
      token: token,
      userName: userName,
    );
  }
}
