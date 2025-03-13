// To parse this JSON data, do
//
//     final GenreModel = GenreModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';



class GenreModel {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;


  GenreModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,

  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    int id = json["id"];

    return GenreModel(
      id: id,
      name: json["name"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),

    );
  }


}
