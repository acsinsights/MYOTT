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
  Color? color; // ✅ Nullable color field


  GenreModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.color, // ✅ Initialize color field

  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    int id = json["id"];

    return GenreModel(
      id: id,
      name: json["name"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      color: Color(colors[id % colors.length]), // ✅ Convert int to Color

    );
  }


}
final List<int> colors = [
  0xFF3B3B98,
  0xFF8D4E3F,
  0xFF5D5D81,
  0xFF725285,
  0xFFA97E36,
  0xFF3B8D78,
  0xFF3B3B98,
  0xFF8D4E3F,
  0xFF5D5D81,
  0xFF725285,
  0xFFA97E36,
  0xFF3B8D78,
];
