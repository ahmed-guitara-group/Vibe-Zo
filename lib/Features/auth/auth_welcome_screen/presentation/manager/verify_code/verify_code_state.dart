part of 'verify_code_cubit.dart';

@immutable
sealed class VerifyCodeState {}

final class VerifyCodeInitial extends VerifyCodeState {}

class VerifyCodeLoading extends VerifyCodeState {
  VerifyCodeLoading();
}

class VerifyCodeSuccessful extends VerifyCodeState {
  final SendCodeModel response;

  VerifyCodeSuccessful(this.response);
}

class VerifyCodeFailed extends VerifyCodeState {
  final String errorCode;
  VerifyCodeFailed(this.errorCode);
}
