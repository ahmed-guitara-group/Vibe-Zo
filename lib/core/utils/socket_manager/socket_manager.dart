import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  factory SocketManager() => _instance;

  SocketManager._internal();

  late IO.Socket _chatSocket;

  IO.Socket get chatSocket => _chatSocket;

  void initChatSocket(String userId) {
    _chatSocket = IO.io(
      'http://your-backend-url',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setQuery({'userId': userId})
          .build(),
    );

    _chatSocket.connect();

    _chatSocket.onConnect((_) {
      print('✅ Connected to chat socket');
    });

    _chatSocket.onDisconnect((_) {
      print('❌ Disconnected from chat socket');
    });

    _chatSocket.onError((err) {
      print('⚠️ Socket error: $err');
    });
  }

  void disposeChatSocket() {
    _chatSocket.dispose();
  }
}
