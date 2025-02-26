// To parse this JSON data, do
//
//     final blogModel = blogModelFromJson(jsonString);

import 'dart:convert';

List<BlogModel> blogModelFromJson(String str) => List<BlogModel>.from(json.decode(str).map((x) => BlogModel.fromJson(x)));

String blogModelToJson(List<BlogModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogModel {
  int id;
  String title;
  String slug;
  int categoryId;
  String thumbnailImg;
  String bannerImg;
  int status;
  int approved;
  int sticky;
  String desc;
  int position;
  int isFeatured;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  BlogModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.categoryId,
    required this.thumbnailImg,
    required this.bannerImg,
    required this.status,
    required this.approved,
    required this.sticky,
    required this.desc,
    required this.position,
    required this.isFeatured,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    categoryId: json["category_id"],
    thumbnailImg: json["thumbnail_img"],
    bannerImg: json["banner_img"],
    status: json["status"],
    approved: json["approved"],
    sticky: json["sticky"],
    desc: json["desc"],
    position: json["position"],
    isFeatured: json["is_featured"],
    deletedAt: json["deleted_at"],
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
    "desc": desc,
    "position": position,
    "is_featured": isFeatured,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
