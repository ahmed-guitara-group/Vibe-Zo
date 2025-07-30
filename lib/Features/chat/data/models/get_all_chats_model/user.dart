import 'profile_photo.dart';

class User {
  int? id;
  String? name;
  String? username;
  ProfilePhoto? profilePhoto;

  User({this.id, this.name, this.username, this.profilePhoto});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int?,
    name: json['name'] as String?,
    username: json['username'] as String?,
    profilePhoto: json['profilePhoto'] == null
        ? null
        : ProfilePhoto.fromJson(json['profilePhoto'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'username': username,
    'profilePhoto': profilePhoto?.toJson(),
  };
}
