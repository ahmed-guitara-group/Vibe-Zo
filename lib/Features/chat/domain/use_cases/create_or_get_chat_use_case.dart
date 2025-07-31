//Verify Code Use Case

import '../../data/models/create_or_get_chat_model/create_or_get_chat_model.dart';
import '../../data/remote_data_source.dart/get_all_chats_remote_data_source.dart';
import '../repos/get_all_chat_repo.dart';

abstract class UseCase<type> {
  Future<CreateOrGetChatResponse> call(String token, String toUserId);
}

class CreateOrGetChatUseCase extends UseCase<CreateOrGetChatModel> {
  final CreateOrGetChatRepo createOrGetChatRepo;
  CreateOrGetChatUseCase(this.createOrGetChatRepo);

  @override
  Future<CreateOrGetChatResponse> call(String token, String toUserId) async {
    return await createOrGetChatRepo.createOrGetChat(token, toUserId);
  }
}
