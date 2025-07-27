import 'dart:io';

import 'package:vibe_zo/Features/auth/setup_profile/data/data_source/setup_profile_remote_data_source.dart';

abstract class SetupProfileRepo {
  Future<SetupProfileResponse> setupProfile({
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
