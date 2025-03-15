

  class ActorsModel {
  int id;
  String name;
  String image;
  String? type;
  String? description;


  ActorsModel({
    required this.id,
    required this.name,
    required this.image,
     this.type,
     this.description,

  });

  factory ActorsModel.fromJson(Map<String, dynamic> json) => ActorsModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    type: json["type"] ?? " ",
    description: json["description"] ?? " ",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "type": type,
    "description": description,

  };
}
