//Verify Code Use Case

import 'package:vibe_zo/Features/auth/auth_welcome_screen/data/models/send_code_model/send_code_model.dart';
import 'package:vibe_zo/Features/chat/data/models/create_oro_get_chat_model/create_oro_get_chat_model.dart';

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
