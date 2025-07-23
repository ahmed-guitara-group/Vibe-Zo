part of 'register_phone_cubit.dart';

abstract class RegisterPhoneState {
  const RegisterPhoneState();
  List<Object> get props => [];
}

class RegisterPhoneInitial extends RegisterPhoneState {}

class RegisterPhoneLoading extends RegisterPhoneState {
  const RegisterPhoneLoading();
}

class RegisterPhoneSuccessful extends RegisterPhoneState {
  final RegisterPhoneModel response;

  const RegisterPhoneSuccessful(this.response);
}

class RegisterPhoneFailed extends RegisterPhoneState {
  final String message;
  const RegisterPhoneFailed(this.message);
}
