import 'dart:convert';

// To parse this JSON data, do
//
//     final AudioModel = AudioModelFromJson(jsonString);


List<AudioModel> AudioModelFromJson(String str) => List<AudioModel>.from(json.decode(str).map((x) => AudioModel.fromJson(x)));

String AudioModelToJson(List<AudioModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AudioModel {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  int? color; // ✅ Nullable color field

  AudioModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.color, // ✅ Initialize color field
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) => AudioModel(
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
