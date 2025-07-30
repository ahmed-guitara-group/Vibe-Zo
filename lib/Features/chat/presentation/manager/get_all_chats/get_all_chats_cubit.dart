import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vibe_zo/Features/chat/data/models/get_all_chats_model/get_all_chats_model.dart';

import '../../../../../core/utils/socket_manager/socket_manager.dart';
import '../../../domain/use_cases/get_all_chats_use_case.dart';

part 'get_all_chats_state.dart';

class GetAllChatsCubit extends Cubit<GetAllChatsState> {
  GetAllChatsUseCase getAllChatsUseCase;
  GetAllChatsCubit(this.getAllChatsUseCase) : super(GetAllChatsInitial());

  Future<void> getAllChats(String token) async {
    emit(const GetAllChatsLoading());
    final result = await getAllChatsUseCase.call(token);

    emit(result.fold(GetAllChatsFailed.new, GetAllChatsSuccessful.new));
  }

  //ALL CHATS
  void connectSocket({required userId, required channelId}) {
    SocketManager().initSocketForChannel(
      //cURRENT USER ID
      userId: userId,
      channelName: "chats/$channelId",
    );
  }
}
