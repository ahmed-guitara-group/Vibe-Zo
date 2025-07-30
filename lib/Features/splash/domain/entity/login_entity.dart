import 'package:hive/hive.dart';

part 'login_entity.g.dart';

@HiveType(typeId: 0)
class LoginEntity extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String gender;

  @HiveField(5)
  final String country;

  @HiveField(6)
  final String speakLanguage;

  @HiveField(7)
  final DateTime birthDate;

  @HiveField(8)
  final String profileImageName;

  LoginEntity({
    required this.id,
    required this.username,
    required this.name,
    required this.phone,
    required this.gender,
    required this.country,
    required this.speakLanguage,
    required this.birthDate,
    required this.profileImageName,
  });

  factory LoginEntity.fromJson(Map<String, dynamic> json) {
    return LoginEntity(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      phone: json['phone'],
      gender: json['gender'],
      country: json['country'],
      speakLanguage: json['speakLanguage'],
      birthDate: DateTime.parse(json['birthDate']),
      profileImageName: json['profilePhoto']?['photo']?['name'] ?? '',
    );
  }
}
