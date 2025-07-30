import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:vibe_zo/core/utils/network/api/network_api.dart';

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  factory SocketManager() => _instance;

  SocketManager._internal();

  final Map<String, IO.Socket> _sockets = {}; //   كل تشانل بسوكيتها

  IO.Socket? getSocket(String channelName) => _sockets[channelName];

  void initSocketForChannel({
    required String userId,
    required String channelName,
  }) {
    if (_sockets.containsKey(channelName)) {
      print('🟡 Socket already initialized for $channelName');
      return;
    }

    final socket = IO.io(
      Api.socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableReconnection()
          .setReconnectionAttempts(5)
          .setReconnectionDelay(2000)
          .disableAutoConnect()
          .setQuery({'userName': userId, 'channelName': channelName})
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print('✅ Connected to socket for $channelName');
    });

    socket.onDisconnect((_) {
      print('❌ Disconnected from socket for $channelName');
    });

    socket.onConnectError((err) {
      print('⚠️ Connect error on $channelName: $err');
    });

    socket.onError((err) {
      print('🚨 Socket error on $channelName: $err');
    });

    socket.onReconnect((_) {
      print('🔄 Socket reconnected for $channelName');
    });

    socket.onReconnectFailed((_) {
      print('❌ Reconnection failed for $channelName');
    });

    _sockets[channelName] = socket;
  }

  void disconnectSocket(String channelName) {
    final socket = _sockets[channelName];
    socket?.disconnect();
    print("🔌 Disconnected socket for $channelName");
  }

  void disposeSocket(String channelName) {
    final socket = _sockets[channelName];
    socket?.dispose();
    _sockets.remove(channelName);
    print("🗑️ Disposed socket for $channelName");
  }

  bool isConnected(String channelName) {
    return _sockets[channelName]?.connected ?? false;
  }

  void disposeAll() {
    for (var socket in _sockets.values) {
      socket.dispose();
    }
    _sockets.clear();
    print("🗑️ Disposed ALL sockets");
  }
}
