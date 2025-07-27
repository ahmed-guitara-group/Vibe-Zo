import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'setup_profile_state.dart';

class SetupProfileCubit extends Cubit<SetupProfileState> {
  SetupProfileCubit() : super(SetupProfileInitial());

  String? name;
  String? idNumber;
  String? gender;
  String? birthDate;
  File? profileImage;

  void changeStep(int step) {
    step == 1 ? emit(SetupProfileStepOne()) : emit(SetupProfileStepTwo());
  }

  void saveProfileData({
    required String name,
    required String idNumber,
    required String gender,
    required String birthDate,
    required File? image,
  }) {
    this.name = name;
    this.idNumber = idNumber;
    this.gender = gender;
    this.birthDate = birthDate;
    profileImage = image;

    emit(SetupProfileStepOneDataSaved()); // Optional state
  }
}
