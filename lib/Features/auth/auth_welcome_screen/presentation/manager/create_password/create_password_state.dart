part of 'create_password_cubit.dart';

@immutable
sealed class CreatePasswordState {}

final class CreatePasswordInitial extends CreatePasswordState {}

class CreatePasswordLoading extends CreatePasswordState {
  CreatePasswordLoading();
}

class CreatePasswordSuccessful extends CreatePasswordState {
  final SendCodeModel response;

  CreatePasswordSuccessful(this.response);
}

class CreatePasswordFailed extends CreatePasswordState {
  final String errorCode;
  CreatePasswordFailed(this.errorCode);
}
