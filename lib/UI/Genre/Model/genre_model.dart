




class GenreModel {
  int id;
  String name;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;


  GenreModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,

  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    int id = json["id"];

    return GenreModel(
      id: id,
      name: json["name"],
      slug: json["slug"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),

    );
  }


}
