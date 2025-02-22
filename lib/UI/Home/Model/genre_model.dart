class GenreModel {
  final String name;
  final String image;
  final int color;

  GenreModel({
    required this.name,
    required this.image,
    required this.color,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      name: json["name"]!,
      image: json["image"]!,
      color: int.parse(json["color"]!),
    );
  }
}
