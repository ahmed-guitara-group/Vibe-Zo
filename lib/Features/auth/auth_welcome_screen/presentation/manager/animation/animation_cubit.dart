import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'animation_state.dart';

class AnimationCubit extends Cubit<AnimationState> {
  AnimationCubit() : super(AnimationInitial());
  bool isShowAllLangs = false;
  bool isShowAllCountries = false;
  void moveButtonDown() async {
    emit(AnimationInitial());
    emit(ButtonMovedDown());
  }

  void hideVerificationMethod() async {
    emit(AnimationInitial());

    emit(VerificationMethodSelected());
  }

  void hideVerOtpField() async {
    emit(AnimationInitial());

    emit(ShowVerificationMethod());
  }

  void showAllLanguages() {
    emit(AnimationInitial());
    isShowAllLangs = !isShowAllLangs;
    emit(ShowAllLangs());
  }

  void showAllCountries() {
    emit(AnimationInitial());
    isShowAllCountries = !isShowAllCountries;
    emit(ShowAllCountries());
  }
}
