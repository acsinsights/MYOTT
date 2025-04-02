

  class ActorsModel {
  int id;
  String name;
  String image;
  String? type;
  String slug;
  String description;


  ActorsModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
     this.type,
    required this.description,

  });

  factory ActorsModel.fromJson(Map<String, dynamic> json) => ActorsModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    slug: json["slug"] ?? "",
    type: json["type"] ?? " ",
    description: json["description"]?.toString() ?? " ",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "slug": slug,
    "type": type,
    "description": description,

  };
}
