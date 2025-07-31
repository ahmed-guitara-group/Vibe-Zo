part of 'send_message_cubit.dart';

@immutable
sealed class SendMessageState {
  const SendMessageState();
  List<Object> get props => [];
}

final class SendMessageInitial extends SendMessageState {}

class SendMessageLoading extends SendMessageState {
  const SendMessageLoading();
}

class SendMessageSuccessful extends SendMessageState {
  final SendMessageModel chatMessages;

  const SendMessageSuccessful(this.chatMessages);
}

class SendMessageFailed extends SendMessageState {
  final String message;
  const SendMessageFailed(this.message);
}
