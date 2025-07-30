class OtherUser {
  int? id;
  String? name;
  String? username;
  String? gender;
  String? country;
  dynamic profilePhoto;
  bool? isOnline;
  bool? isLive;

  OtherUser({
    this.id,
    this.name,
    this.username,
    this.gender,
    this.country,
    this.profilePhoto,
    this.isOnline,
    this.isLive,
  });

  factory OtherUser.fromJson(Map<String, dynamic> json) => OtherUser(
    id: json['id'] as int?,
    name: json['name'] as String?,
    username: json['username'] as String?,
    gender: json['gender'] as String?,
    country: json['country'] as String?,
    profilePhoto: json['profilePhoto'] as dynamic,
    isOnline: json['isOnline'] as bool?,
    isLive: json['isLive'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'username': username,
    'gender': gender,
    'country': country,
    'profilePhoto': profilePhoto,
    'isOnline': isOnline,
    'isLive': isLive,
  };
}
