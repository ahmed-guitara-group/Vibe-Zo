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
    _messages.insert(0, message); // 👈 عشان تظهر فوق في ListView.reverse
    emit(ChatMessagesUpdated(List.from(_messages)));
  }

  void updateMessageFromSocket(Message newMessage) {
    // ❗ فلتر الرسالة لو هي من المستخدم الحالي (لأنها أضيفت بالفعل محليًا)
    if (newMessage.isFromMe == true) return;

    final index = _messages.indexWhere((msg) => msg.id == newMessage.id);
    if (index != -1) {
      _messages[index] = newMessage;
    } else {
      _messages.insert(0, newMessage);
    }
    emit(ChatMessagesUpdated(List.from(_messages)));
  }

  void clearMessages() {
    _messages.clear();
    emit(ChatMessagesUpdated([]));
  }
}
