import 'profile_photo.dart';

class User {
  int? id;
  String? username;
  String? name;
  String? phone;
  String? accountStatus;
  int? isVerified;
  String? gender;
  String? country;
  String? speakLanguage;
  DateTime? birthDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  ProfilePhoto? profilePhoto;

  User({
    this.id,
    this.username,
    this.name,
    this.phone,
    this.accountStatus,
    this.isVerified,
    this.gender,
    this.country,
    this.speakLanguage,
    this.birthDate,
    this.createdAt,
    this.updatedAt,
    this.profilePhoto,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int?,
    username: json['username'] as String?,
    name: json['name'] as String?,
    phone: json['phone'] as String?,
    accountStatus: json['accountStatus'] as String?,
    isVerified: json['isVerified'] as int?,
    gender: json['gender'] as String?,
    country: json['country'] as String?,
    speakLanguage: json['speakLanguage'] as String?,
    birthDate: json['birthDate'] == null
        ? null
        : DateTime.parse(json['birthDate'] as String),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    profilePhoto: json['profilePhoto'] == null
        ? null
        : ProfilePhoto.fromJson(json['profilePhoto'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'name': name,
    'phone': phone,
    'accountStatus': accountStatus,
    'isVerified': isVerified,
    'gender': gender,
    'country': country,
    'speakLanguage': speakLanguage,
    'birthDate': birthDate?.toIso8601String(),
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'profilePhoto': profilePhoto?.toJson(),
  };
}
