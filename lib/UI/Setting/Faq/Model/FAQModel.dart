// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

List<FaqModel> faqModelFromJson(String str) => List<FaqModel>.from(json.decode(str).map((x) => FaqModel.fromJson(x)));

String faqModelToJson(List<FaqModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FaqModel {
  int id;
  String question;
  String answer;
  int status;
  int position;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  FaqModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.status,
    required this.position,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    id: json["id"],
    question: json["question"],
    answer: json["answer"],
    status: json["status"],
    position: json["position"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answer": answer,
    "status": status,
    "position": position,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
