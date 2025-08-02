part of 'get_chat_messages_cubit.dart';

@immutable
sealed class GetChatMessagesState {
  const GetChatMessagesState();
  List<Object> get props => [];
}

final class GetChatMessagesInitial extends GetChatMessagesState {}

class GetChatMessagesLoading extends GetChatMessagesState {
  const GetChatMessagesLoading();
}

class GetChatMessagesSuccessful extends GetChatMessagesState {
  final GetChatMessagesModel chatMessages;

  const GetChatMessagesSuccessful(this.chatMessages);
}

class GetChatMessagesFailed extends GetChatMessagesState {
  final String message;
  const GetChatMessagesFailed(this.message);
}

class NewMessageReceived extends GetChatMessagesState {
  final Message message;
  final bool isFromSelf;
  const NewMessageReceived(this.message, this.isFromSelf);
}
