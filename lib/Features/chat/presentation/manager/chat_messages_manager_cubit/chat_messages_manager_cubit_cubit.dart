import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/send_message_model/message.dart';

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
    _messages.add(message);
    emit(ChatMessagesUpdated(List.from(_messages)));
  }

  void updateMessageFromSocket(Message newMessage) {
    // إذا كان فيه رسالة موقّتة بنفس الـ ID (مثلاً id = "temp_123")
    final index = _messages.indexWhere((msg) => msg.id == newMessage.id);
    if (index != -1) {
      _messages[index] = newMessage;
    } else {
      _messages.add(newMessage); // لو مش موجودة، ضيفها عادي
    }
    emit(ChatMessagesUpdated(List.from(_messages)));
  }

  void clearMessages() {
    _messages.clear();
    emit(ChatMessagesUpdated([]));
  }
}
