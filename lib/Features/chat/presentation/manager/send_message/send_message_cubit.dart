import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/send_message_model/send_message_model.dart';
import '../../../domain/use_cases/send_message_use_case.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageUseCase sendMessageUseCase;

  SendMessageCubit(this.sendMessageUseCase) : super(SendMessageInitial());
  Future<void> sendMessage({
    required String token,
    required String chatId,
    required String type,
    required String message,
  }) async {
    emit(const SendMessageLoading());
    final result = await sendMessageUseCase.call(
      chatId: chatId,
      token: token,
      type: type,
      message: message,
    );

    emit(result.fold(SendMessageFailed.new, SendMessageSuccessful.new));
  }
}
