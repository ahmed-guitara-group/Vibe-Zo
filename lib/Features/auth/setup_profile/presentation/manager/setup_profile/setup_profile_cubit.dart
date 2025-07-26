import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'setup_profile_state.dart';

class SetupProfileCubit extends Cubit<SetupProfileState> {
  SetupProfileCubit() : super(SetupProfileInitial());
  void changeStep(int step) =>
      step == 1 ? emit(SetupProfileStepOne()) : emit((SetupProfileStepTwo()));
  //SelectedCountries Array
  // Selected Langs Array
}
