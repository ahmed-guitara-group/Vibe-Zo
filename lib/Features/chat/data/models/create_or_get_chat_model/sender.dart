class Sender {
  int? id;
  String? name;
  String? username;

  Sender({this.id, this.name, this.username});

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json['id'] as int?,
    name: json['name'] as String?,
    username: json['username'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'username': username,
  };
}
