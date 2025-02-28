import 'dart:convert';

// To parse this JSON data, do
//
//     final langModel = langModelFromJson(jsonString);


List<LangModel> langModelFromJson(String str) => List<LangModel>.from(json.decode(str).map((x) => LangModel.fromJson(x)));

String langModelToJson(List<LangModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LangModel {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  int? color; // ✅ Nullable color field

  LangModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.color, // ✅ Initialize color field
  });

  factory LangModel.fromJson(Map<String, dynamic> json) => LangModel(
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
