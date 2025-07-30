class Token {
  String? type;
  String? name;
  String? token;
  List<dynamic>? abilities;
  dynamic lastUsedAt;
  DateTime? expiresAt;

  Token({
    this.type,
    this.name,
    this.token,
    this.abilities,
    this.lastUsedAt,
    this.expiresAt,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    type: json['type'] as String?,
    name: json['name'] as String?,
    token: json['token'] as String?,
    abilities: json['abilities'] as List<dynamic>?,
    lastUsedAt: json['lastUsedAt'] as dynamic,
    expiresAt: json['expiresAt'] == null
        ? null
        : DateTime.parse(json['expiresAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'name': name,
    'token': token,
    'abilities': abilities,
    'lastUsedAt': lastUsedAt,
    'expiresAt': expiresAt?.toIso8601String(),
  };
}
