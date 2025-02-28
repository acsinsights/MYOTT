// To parse this JSON data, do
//
//     final languageModel = languageModelFromJson(jsonString);

import 'dart:convert';

List<LanguageModel> languageModelFromJson(String str) => List<LanguageModel>.from(json.decode(str).map((x) => LanguageModel.fromJson(x)));

String languageModelToJson(List<LanguageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LanguageModel {
  int id;
  String local;
  String name;
  int status;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  LanguageModel({
    required this.id,
    required this.local,
    required this.name,
    required this.status,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
    id: json["id"],
    local: json["local"],
    name: json["name"],
    status: json["status"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "local": local,
    "name": name,
    "status": status,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
