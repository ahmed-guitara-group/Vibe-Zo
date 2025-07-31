class OtherUser {
  int? id;
  String? name;
  String? username;
  String? gender;
  String? country;

  OtherUser({this.id, this.name, this.username, this.gender, this.country});

  factory OtherUser.fromJson(Map<String, dynamic> json) => OtherUser(
    id: json['id'] as int?,
    name: json['name'] as String?,
    username: json['username'] as String?,
    gender: json['gender'] as String?,
    country: json['country'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'username': username,
    'gender': gender,
    'country': country,
  };
}
