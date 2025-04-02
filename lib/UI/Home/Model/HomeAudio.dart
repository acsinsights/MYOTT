
class HomeAudio {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  final String slug;

  HomeAudio({
    required this.id,
    this.slug="hindi",
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HomeAudio.fromJson(Map<String, dynamic> json) {
    int id = json["id"];
    return HomeAudio(
      id: id,
      name: json["name"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }
}

