//Verify Code Use Case

import '../../data/models/get_chat_messages_model/get_chat_messages_model.dart';
import '../../data/remote_data_source.dart/get_all_chats_remote_data_source.dart';
import '../repos/get_all_chat_repo.dart';

abstract class UseCase<type> {
  Future<GetChatMessagesResponse> call(String token, String chatId);
}

class GetChatMessagesUseCase extends UseCase<GetChatMessagesModel> {
  final GetChatMessagesRepo getChatMessagesRepo;
  GetChatMessagesUseCase(this.getChatMessagesRepo);

  @override
  Future<GetChatMessagesResponse> call(String token, String chatId) async {
    return await getChatMessagesRepo.getChatMessages(token, chatId);
  }
}
