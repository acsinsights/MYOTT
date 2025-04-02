




class HomeGenreModel {
  int id;
  String name;
  String slug;
  DateTime createdAt;
  DateTime updatedAt;


  HomeGenreModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,

  });

  factory HomeGenreModel.fromJson(Map<String, dynamic> json) {
    int id = json["id"];

    return HomeGenreModel(
      id: id,
      name: json["name"],
      slug: json["slug"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),

    );
  }


}
