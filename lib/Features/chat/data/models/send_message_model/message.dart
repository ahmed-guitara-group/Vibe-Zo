class Message {
  String? chatId;
  int? senderId;
  String? messageType;
  DateTime? createdAt;
  int? id;

  Message({
    this.chatId,
    this.senderId,
    this.messageType,
    this.createdAt,
    this.id,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    chatId: json['chatId'] as String?,
    senderId: json['senderId'] as int?,
    messageType: json['messageType'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    id: json['id'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'chatId': chatId,
    'senderId': senderId,
    'messageType': messageType,
    'createdAt': createdAt?.toIso8601String(),
    'id': id,
  };
}
