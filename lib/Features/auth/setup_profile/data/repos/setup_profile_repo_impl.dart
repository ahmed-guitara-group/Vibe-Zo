import 'dart:io';

import '../../domain/repos/setup_profile_repo.dart';
import '../data_source/setup_profile_remote_data_source.dart';

class SetupProfileRepoImpl extends SetupProfileRepo {
  final SetupProfileRemoteDataSource setupProfileRemoteDataSource;

  SetupProfileRepoImpl(this.setupProfileRemoteDataSource);

  @override
  Future<SetupProfileResponse> setupProfile({
    required String userName,
    required String name,
    required String birthDate,
    required String gender,
    required List<String> spokenLanguages,
    required List<String> countries,
    required File photo,
    required String token,
  }) async {
    var userData = await setupProfileRemoteDataSource.setupProfile(
      userName: userName,
      name: name,
      birthDate: birthDate,
      gender: gender,
      spokenLanguages: spokenLanguages,
      countries: countries,
      photo: photo,
      token: token,
    );
    return userData;
  }
}
