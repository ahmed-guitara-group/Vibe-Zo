import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vibe_zo/Features/chat/domain/use_cases/create_or_get_chat_use_case.dart';

import '../../../../../core/utils/socket_manager/socket_manager.dart';
import '../../../data/models/create_or_get_chat_model/create_or_get_chat_model.dart';

part 'create_or_get_chat_state.dart';

class CreateOrGetChatCubit extends Cubit<CreateOrGetChatState> {
  CreateOrGetChatUseCase createOrGetChatUseCase;
  CreateOrGetChatCubit(this.createOrGetChatUseCase)
    : super(CreateOrGetChatInitial());

  Future<void> createOrGetChat(String token, String toUserId) async {
    emit(const CreateOrGetChatLoading());
    final result = await createOrGetChatUseCase.call(token, toUserId);

    emit(result.fold(CreateOrGetChatFailed.new, CreateOrGetChatSuccessful.new));
  }

  //ALL CHATS
  void connectChatSocket({required userId, required channelId}) {
    SocketManager().initSocketForChannel(
      //cURRENT USER ID
      userId: userId,
      channelName: "chats/$channelId",
    );
  }
}
