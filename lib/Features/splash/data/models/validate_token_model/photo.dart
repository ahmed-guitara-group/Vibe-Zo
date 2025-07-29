import 'meta.dart';

class Photo {
  String? name;
  String? originalName;
  int? size;
  String? extname;
  String? mimeType;
  Meta? meta;

  Photo({
    this.name,
    this.originalName,
    this.size,
    this.extname,
    this.mimeType,
    this.meta,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    name: json['name'] as String?,
    originalName: json['originalName'] as String?,
    size: json['size'] as int?,
    extname: json['extname'] as String?,
    mimeType: json['mimeType'] as String?,
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'originalName': originalName,
    'size': size,
    'extname': extname,
    'mimeType': mimeType,
    'meta': meta?.toJson(),
  };
}
