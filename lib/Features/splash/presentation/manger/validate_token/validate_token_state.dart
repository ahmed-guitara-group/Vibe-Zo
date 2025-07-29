part of 'validate_token_cubit.dart';

@immutable
sealed class ValidateTokenState {}

final class ValidateTokenInitial extends ValidateTokenState {}

class ValidateTokenLoading extends ValidateTokenState {
  ValidateTokenLoading();
}

class ValidateTokenSuccessful extends ValidateTokenState {
  final ValidateTokenModel user;

  ValidateTokenSuccessful(this.user);
}

class ValidateTokenFailed extends ValidateTokenState {
  final String message;
  ValidateTokenFailed(this.message);
}
