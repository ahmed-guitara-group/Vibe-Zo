//Verify Code Use Case

import 'package:vibe_zo/Features/auth/auth_welcome_screen/data/models/send_code_model/send_code_model.dart';

import '../../data/remote_data_source.dart/get_all_chats_remote_data_source.dart';
import '../repos/get_all_chat_repo.dart';

abstract class UseCase<type> {
  Future<GetAllChatsResponse> call(String token);
}

class GetAllChatsUseCase extends UseCase<SendCodeModel> {
  final GetAllChatsRepo getAllChatsRepo;
  GetAllChatsUseCase(this.getAllChatsRepo);

  @override
  Future<GetAllChatsResponse> call(String token) async {
    return await getAllChatsRepo.getAllChats(token);
  }
}
