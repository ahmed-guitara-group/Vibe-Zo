//Verify Code Use Case

import '../../data/models/send_message_model/send_message_model.dart';
import '../../data/remote_data_source.dart/get_all_chats_remote_data_source.dart';
import '../repos/get_all_chat_repo.dart';

abstract class UseCase<type> {
  Future<SendMessageResponse> call({
    required String token,
    required String chatId,
    required String type,
    required String message,
  });
}

class SendMessageUseCase extends UseCase<SendMessageModel> {
  final SendMessageRepo sendMessageRepo;
  SendMessageUseCase(this.sendMessageRepo);

  @override
  Future<SendMessageResponse> call({
    required String token,
    required String chatId,
    required String type,
    required String message,
  }) async {
    return await sendMessageRepo.sendMessage(
      chatId: chatId,
      token: token,
      type: type,
      message: message,
    );
  }
}
