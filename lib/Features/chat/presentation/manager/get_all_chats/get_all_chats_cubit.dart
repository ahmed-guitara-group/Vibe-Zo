import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vibe_zo/Features/chat/data/models/get_all_chats_model/get_all_chats_model.dart';

import '../../../../../core/utils/socket_manager/socket_manager.dart';
import '../../../domain/use_cases/get_all_chats_use_case.dart';

part 'get_all_chats_state.dart';

class GetAllChatsCubit extends Cubit<GetAllChatsState> {
  final GetAllChatsUseCase getAllChatsUseCase;

  GetAllChatsCubit(this.getAllChatsUseCase) : super(GetAllChatsInitial());

  Future<void> getAllChats(String token) async {
    emit(const GetAllChatsLoading());
    final result = await getAllChatsUseCase.call(token);
    if (isClosed) return;
    emit(result.fold(GetAllChatsFailed.new, GetAllChatsSuccessful.new));
  }

  void connectAllChatSocket({
    required String userId,
    required String channelId,
  }) {
    final fullChannelName = "chats/$channelId";
    final socketManager = SocketManager();

    if (!socketManager.isConnected(fullChannelName)) {
      socketManager.initSocketForChannel(
        userId: userId,
        channelName: fullChannelName,
      );
    } else {
      print('🟢 Socket already connected to $fullChannelName');
    }
  }

  void disconnectAllChatSocket({required String channelId}) {
    final fullChannelName = "chats/$channelId";
    SocketManager().disconnectSocket(fullChannelName);
    SocketManager().disposeSocket(fullChannelName);
  }
}
