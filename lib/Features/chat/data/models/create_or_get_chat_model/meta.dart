import 'dimension.dart';
import 'orientation.dart';

class Meta {
  String? date;
  String? host;
  Dimension? dimension;
  Orientation? orientation;

  Meta({this.date, this.host, this.dimension, this.orientation});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    date: json['date'] as String?,
    host: json['host'] as String?,
    dimension: json['dimension'] == null
        ? null
        : Dimension.fromJson(json['dimension'] as Map<String, dynamic>),
    orientation: json['orientation'] == null
        ? null
        : Orientation.fromJson(json['orientation'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'date': date,
    'host': host,
    'dimension': dimension?.toJson(),
    'orientation': orientation?.toJson(),
  };
}
