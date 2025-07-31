class Orientation {
  String? description;

  Orientation({this.description});

  factory Orientation.fromJson(Map<String, dynamic> json) =>
      Orientation(description: json['description'] as String?);

  Map<String, dynamic> toJson() => {'description': description};
}
