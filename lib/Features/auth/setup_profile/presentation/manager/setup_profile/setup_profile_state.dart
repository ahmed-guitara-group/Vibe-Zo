part of 'setup_profile_cubit.dart';

@immutable
sealed class SetupProfileState {}

final class SetupProfileInitial extends SetupProfileState {}

class SetupProfileLoading extends SetupProfileState {
  SetupProfileLoading();
}

class SetupProfileSuccessful extends SetupProfileState {
  final SendCodeModel user;

  SetupProfileSuccessful(this.user);
}

class SetupProfileFailed extends SetupProfileState {
  final String message;
  SetupProfileFailed(this.message);
}
