part of 'chat_messages_manager_cubit_cubit.dart';

@immutable
sealed class ChatMessagesManagerState {
  const ChatMessagesManagerState();
}

final class ChatMessagesManagerInitial extends ChatMessagesManagerState {}

final class ChatMessagesUpdated extends ChatMessagesManagerState {
  final List<Message> messages;

  const ChatMessagesUpdated(this.messages);
}
