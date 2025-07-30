part of 'create_or_get_chat_cubit.dart';

@immutable
sealed class CreateOrGetChatState {
  const CreateOrGetChatState();
  List<Object> get props => [];
}

final class CreateOrGetChatInitial extends CreateOrGetChatState {}

class CreateOrGetChatLoading extends CreateOrGetChatState {
  const CreateOrGetChatLoading();
}

class CreateOrGetChatSuccessful extends CreateOrGetChatState {
  final CreateOrGetChatModel response;

  const CreateOrGetChatSuccessful(this.response);
}

class CreateOrGetChatFailed extends CreateOrGetChatState {
  final String message;
  const CreateOrGetChatFailed(this.message);
}
