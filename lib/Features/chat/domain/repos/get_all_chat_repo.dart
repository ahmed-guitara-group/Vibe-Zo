import '../../data/remote_data_source.dart/get_all_chats_remote_data_source.dart';

abstract class GetAllChatsRepo {
  Future<GetAllChatsResponse> getAllChats(String token);
}

abstract class CreateOrGetChatRepo {
  Future<CreateOrGetChatResponse> createOrGetChat(
    String token,
    String toUserId,
  );
}

abstract class GetChatMessagesRepo {
  Future<GetChatMessagesResponse> getChatMessages(String token, String chatId);
}
