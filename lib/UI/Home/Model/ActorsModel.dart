// To parse this JSON data, do
//
//     final actorsModel = actorsModelFromJson(jsonString);

import 'dart:convert';

List<ActorsModel> actorsModelFromJson(String str) => List<ActorsModel>.from(json.decode(str).map((x) => ActorsModel.fromJson(x)));

String actorsModelToJson(List<ActorsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActorsModel {
  int id;
  String name;
  String slug;
  String image;
  String type;
  String description;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  ActorsModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.type,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ActorsModel.fromJson(Map<String, dynamic> json) => ActorsModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
    type: json["type"],
    description: json["description"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "image": image,
    "type": type,
    "description": description,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
