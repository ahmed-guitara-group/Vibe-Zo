import '../../domain/repos/get_all_chat_repo.dart';
import '../remote_data_source.dart/get_all_chats_remote_data_source.dart';

//GetAllChatsRepoImpl
class GetAllChatsRepoImpl extends GetAllChatsRepo {
  final GetAllChatsRemoteDataSource getAllChatsRemoteDataSource;

  GetAllChatsRepoImpl(this.getAllChatsRemoteDataSource);

  @override
  Future<GetAllChatsResponse> getAllChats(String token) async {
    var userData = await getAllChatsRemoteDataSource.getAllChats(token);
    return userData;
  }
}

// CreateOrGetChatRepoImpl
class CreateOrGetChatRepoImpl extends CreateOrGetChatRepo {
  final CreateOrGetChatRemoteDataSource createOrGetRemoteDataSource;

  CreateOrGetChatRepoImpl(this.createOrGetRemoteDataSource);

  @override
  Future<CreateOrGetChatResponse> createOrGetChat(
    String token,
    String toUserID,
  ) async {
    var userData = await createOrGetRemoteDataSource.createOrGet(
      token,
      toUserID,
    );
    return userData;
  }
}
//Get chat messages

class GetChatMessagesRepoImpl extends GetChatMessagesRepo {
  final GetChatMessagesRemoteDataSource getChatMessagesRemoteDataSource;

  GetChatMessagesRepoImpl(this.getChatMessagesRemoteDataSource);

  @override
  Future<GetChatMessagesResponse> getChatMessages(
    String token,
    String chatId,
  ) async {
    var data = await getChatMessagesRemoteDataSource.getChatMessages(
      token,
      chatId,
    );
    return data;
  }
}

//Send Message

class SendMessageRepoImpl extends SendMessageRepo {
  final SendMessageRemoteDataSource sendMessageRemoteDataSource;

  SendMessageRepoImpl(this.sendMessageRemoteDataSource);

  @override
  Future<SendMessageResponse> sendMessage({
    required String token,
    required String chatId,
    required String type,
    required String message,
  }) async {
    var data = await sendMessageRemoteDataSource.sendMessage(
      chatId: chatId,
      token: token,
      type: type,
      message: message,
    );
    return data;
  }
}
