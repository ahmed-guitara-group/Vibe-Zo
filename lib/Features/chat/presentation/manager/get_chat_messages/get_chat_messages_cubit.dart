import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/socket_manager/socket_manager.dart';
import '../../../data/models/get_chat_messages_model/get_chat_messages_model.dart';
import '../../../data/models/get_chat_messages_model/message.dart';
import '../../../domain/use_cases/get_chat_messages_use_case.dart';

part 'get_chat_messages_state.dart';

class GetChatMessagesCubit extends Cubit<GetChatMessagesState> {
  GetChatMessagesUseCase getChatMessagesUseCase;
  GetChatMessagesCubit(this.getChatMessagesUseCase)
    : super(GetChatMessagesInitial());

  Future<void> getChatMessages(String token, String chatId) async {
    emit(const GetChatMessagesLoading());
    final result = await getChatMessagesUseCase.call(token, chatId);

    emit(result.fold(GetChatMessagesFailed.new, GetChatMessagesSuccessful.new));
  }

  //Chat dETAILS

  void connectChatSocket({required String chatId, required String userId}) {
    final channelName = "chat/$chatId";

    SocketManager().initSocketForChannel(
      userId: userId,
      channelName: channelName,
    );

    SocketManager().on(channelName, 'new_message', (data) async {
      final message = Message.fromJson(data);

      print('🟢 Cubit received new_message: $data');
      try {
        if (data['senderId'].toString() == userId) {
          print('🟡 Skipping message from self');

          emit(NewMessageReceived(message, true));
        }

        emit(NewMessageReceived(message, false));
      } catch (e) {
        print('❌ Error parsing message: $e');
      }
    });
  }
}
