import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/get_chat_messages_model/get_chat_messages_model.dart';
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
}
