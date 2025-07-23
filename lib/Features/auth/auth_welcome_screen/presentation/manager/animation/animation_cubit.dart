import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'animation_state.dart';

class AnimationCubit extends Cubit<AnimationState> {
  AnimationCubit() : super(AnimationInitial());

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
}
