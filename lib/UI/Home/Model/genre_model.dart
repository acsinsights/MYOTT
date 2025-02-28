// To parse this JSON data, do
//
//     final GenreModel = GenreModelFromJson(jsonString);

import 'dart:convert';

List<GenreModel> GenreModelFromJson(String str) => List<GenreModel>.from(json.decode(str).map((x) => GenreModel.fromJson(x)));

String GenreModelToJson(List<GenreModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GenreModel {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  int? color; // ✅ Nullable color field


  GenreModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.color, // ✅ Initialize color field

  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "color": color, // ✅ Include color in JSON

  };
}
