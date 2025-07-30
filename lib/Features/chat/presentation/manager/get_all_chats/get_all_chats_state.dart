part of 'get_all_chats_cubit.dart';

@immutable
sealed class GetAllChatsState {
  const GetAllChatsState();
  List<Object> get props => [];
}

final class GetAllChatsInitial extends GetAllChatsState {}

class GetAllChatsLoading extends GetAllChatsState {
  const GetAllChatsLoading();
}

class GetAllChatsSuccessful extends GetAllChatsState {
  final GetAllChatsModel allChats;

  const GetAllChatsSuccessful(this.allChats);
}

class GetAllChatsFailed extends GetAllChatsState {
  final String message;
  const GetAllChatsFailed(this.message);
}
