import 'dimension.dart';

class Meta {
  Dimension? dimension;

  Meta({this.dimension});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    dimension: json['dimension'] == null
        ? null
        : Dimension.fromJson(json['dimension'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {'dimension': dimension?.toJson()};
}
