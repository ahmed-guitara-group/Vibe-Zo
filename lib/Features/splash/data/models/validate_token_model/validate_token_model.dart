import '../../../domain/entity/login_entity.dart';
import 'user.dart';

class ValidateTokenModel extends LoginEntity {
  final bool? status;
  final String? code;
  final String? message;

  ValidateTokenModel({
    this.status,
    this.code,
    this.message,
    required super.id,
    required super.username,
    required super.name,
    required super.phone,
    required super.gender,
    required super.country,
    required super.speakLanguage,
    required super.birthDate,
    required super.profileImageName,
  });

  factory ValidateTokenModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] != null
        ? User.fromJson(json['user'] as Map<String, dynamic>)
        : null;

    return ValidateTokenModel(
      status: json['status'] as bool?,
      code: json['code'] as String?,
      message: json['message'] as String?,
      id: user?.id ?? 0,
      username: user?.username ?? '',
      name: user?.name ?? '',
      phone: user?.phone ?? '',
      gender: user?.gender ?? '',
      country: user?.country ?? '',
      speakLanguage: user?.speakLanguage ?? '',
      birthDate: user?.birthDate ?? DateTime.now(),
      profileImageName: user?.profilePhoto?.photo?.name ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'code': code,
    'message': message,
    'user': {
      'id': id,
      'username': username,
      'name': name,
      'phone': phone,
      'gender': gender,
      'country': country,
      'speakLanguage': speakLanguage,
      'birthDate': birthDate.toIso8601String(),
      'profilePhoto': {
        'photo': {'name': profileImageName},
      },
    },
  };
}
