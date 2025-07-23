class Token {
  String? type;
  String? name;
  String? token;
  List<dynamic>? abilities;

  Token({this.type, this.name, this.token, this.abilities});

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    type: json['type'] as String?,
    name: json['name'] as String?,
    token: json['token'] as String?,
    abilities: json['abilities'] as List<dynamic>?,
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'name': name,
    'token': token,
    'abilities': abilities,
  };
}
