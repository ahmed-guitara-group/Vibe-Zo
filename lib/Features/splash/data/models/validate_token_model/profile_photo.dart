import 'photo.dart';

class ProfilePhoto {
  int? id;
  int? userId;
  Photo? photo;
  String? type;
  DateTime? createdAt;

  ProfilePhoto({this.id, this.userId, this.photo, this.type, this.createdAt});

  factory ProfilePhoto.fromJson(Map<String, dynamic> json) => ProfilePhoto(
    id: json['id'] as int?,
    userId: json['userId'] as int?,
    photo: json['photo'] == null
        ? null
        : Photo.fromJson(json['photo'] as Map<String, dynamic>),
    type: json['type'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'photo': photo?.toJson(),
    'type': type,
    'createdAt': createdAt?.toIso8601String(),
  };
}
