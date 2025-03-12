import 'package:flutter/material.dart';

class AudioModel {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  Color? color; // ✅ Change type to Color

  AudioModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.color, // ✅ Now nullable but correctly assigned
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    int id = json["id"];
    return AudioModel(
      id: id,
      name: json["name"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      color: Color(colors[id % colors.length]), // ✅ Convert int to Color
    );
  }
}

// ✅ Define colors as integer hex values
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
