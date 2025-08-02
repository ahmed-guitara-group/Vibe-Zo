import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/get_chat_messages_model/message.dart';

part 'chat_messages_manager_cubit_state.dart';

class ChatMessagesManagerCubit extends Cubit<ChatMessagesManagerState> {
  ChatMessagesManagerCubit() : super(ChatMessagesManagerInitial());

  List<Message> _messages = [];

  List<Message> get messages => _messages;

  void loadInitialMessages(List<Message> messages) {
    _messages = messages;
    emit(ChatMessagesUpdated(List.from(_messages)));
  }

  void addLocalMessage(Message message) {
    _messages.insert(0, message);
    emit(ChatMessagesUpdated(List.from(_messages)));
  }

  // void updateMessageFromSocket(Message newMessage, bool isFromMe) {
  //   if (isFromMe == true) {
  //     // ابحث عن الرسالة المؤقتة اللي بتتطابق مع دي بالضبط
  //     final index = _messages.indexWhere(
  //       (msg) =>
  //           (msg.isLocal) &&
  //           msg.text == newMessage.text &&
  //           msg.messageType == newMessage.messageType &&
  //           msg.isFromMe == true,
  //       //   msg.repliedTo?.id == newMessage.repliedTo?.id, // لو بتدعم الرد
  //     );

  //     if (index != -1) {
  //       _messages[index] = newMessage;
  //     } else {
  //       newMessage.isFromMe = true;
  //       _messages.insert(0, newMessage);
  //     }
  //   } else {
  //     newMessage.isFromMe = false;

  //     _messages.insert(0, newMessage);
  //   }

  //   emit(ChatMessagesUpdated(List.from(_messages)));
  // }

  void clearMessages() {
    _messages.clear();
    emit(ChatMessagesUpdated([]));
  }
}
