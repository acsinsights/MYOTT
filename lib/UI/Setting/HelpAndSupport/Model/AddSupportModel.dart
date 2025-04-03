// To parse this JSON data, do
//
//     final addSupportModel = addSupportModelFromJson(jsonString);

import 'dart:convert';

AddSupportModel addSupportModelFromJson(String str) => AddSupportModel.fromJson(json.decode(str));

String addSupportModelToJson(AddSupportModel data) => json.encode(data.toJson());

class AddSupportModel {
  bool success;
  String message;
  SupportData? data;

  AddSupportModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AddSupportModel.fromJson(Map<String, dynamic> json) => AddSupportModel(
    success: json["success"] ?? "",
    message: json["message"] ?? "",
    data: json["data"] != null ? SupportData.fromJson(json["data"]) : null,
  );


  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class SupportData {
  String ticketId;
  String supportId;
  String message;
  String imageUrl;

  SupportData({
    required this.ticketId,
    required this.supportId,
    required this.message,
    required this.imageUrl,
  });

  factory SupportData.fromJson(Map<String, dynamic> json) => SupportData(
    ticketId: json["ticket_id"]?.toString() ?? "", // ✅ Convert int to String
    supportId: json["support_id"]?.toString() ?? "", // ✅ Convert int to String
    message: json["message"] ?? "",
    imageUrl: json["image_url"] ?? "",
  );


  Map<String, dynamic> toJson() => {
    "ticket_id": ticketId,
    "support_id": supportId,
    "message": message,
    "image_url": imageUrl,
  };
}
