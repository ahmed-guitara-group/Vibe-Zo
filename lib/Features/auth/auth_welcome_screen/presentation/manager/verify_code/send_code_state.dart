part of 'send_code_cubit.dart';

@immutable
sealed class SendCodeState {}

final class SendCodeInitial extends SendCodeState {}

class SendCodeLoading extends SendCodeState {
  SendCodeLoading();
}

class SendCodeSuccessful extends SendCodeState {
  final SendCodeModel response;

  SendCodeSuccessful(this.response);
}

class SendCodeFailed extends SendCodeState {
  final String errorCode;
  SendCodeFailed(this.errorCode);
}
