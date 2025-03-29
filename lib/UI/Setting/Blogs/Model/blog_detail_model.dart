// To parse this JSON data, do
//
//     final blogdetailsModel = blogdetailsModelFromJson(jsonString);

import 'dart:convert';

BlogdetailsModel blogdetailsModelFromJson(String str) => BlogdetailsModel.fromJson(json.decode(str));

String blogdetailsModelToJson(BlogdetailsModel data) => json.encode(data.toJson());

class BlogdetailsModel {
  bool status;
  String message;
  List<Datum> data;

  BlogdetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BlogdetailsModel.fromJson(Map<String, dynamic> json) => BlogdetailsModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String title;
  String slug;
  String categoryId;
  String thumbnailImg;
  String bannerImg;
  int status;
  int approved;
  int sticky;
  String description;
  int position;
  int isFeatured;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.title,
    required this.slug,
    required this.categoryId,
    required this.thumbnailImg,
    required this.bannerImg,
    required this.status,
    required this.approved,
    required this.sticky,
    required this.description,
    required this.position,
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    categoryId: json["category_id"],
    thumbnailImg: json["thumbnail_img"],
    bannerImg: json["banner_img"],
    status: json["status"],
    approved: json["approved"],
    sticky: json["sticky"],
    description: json["description"],
    position: json["position"],
    isFeatured: json["is_featured"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "category_id": categoryId,
    "thumbnail_img": thumbnailImg,
    "banner_img": bannerImg,
    "status": status,
    "approved": approved,
    "sticky": sticky,
    "description": description,
    "position": position,
    "is_featured": isFeatured,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
