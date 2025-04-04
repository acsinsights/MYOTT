// To parse this JSON data, do
//
//     final blogdetailsModel = blogdetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:myott/UI/Model/BaseCommentsModel.dart';

BlogdetailsModel blogdetailsModelFromJson(String str) => BlogdetailsModel.fromJson(json.decode(str));

String blogdetailsModelToJson(BlogdetailsModel data) => json.encode(data.toJson());

class BlogdetailsModel {
  bool status;
  String message;
  List<Datum> data;
  List<BlogComments> comments;

  BlogdetailsModel({
    required this.status,
    required this.message,
    required this.data,
    required this.comments
  });

  factory BlogdetailsModel.fromJson(Map<String, dynamic> json) => BlogdetailsModel(
    status: json["status"]??false,
    message: json["message"]??"",
    data: json["data"]!=null? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))):[],
    comments:  json["comment"] != null ? List<BlogComments>.from(json["comment"].map((x) => BlogComments.fromJson(x))) : [],
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
    id: json["id"]??"",
    title: json["title"]??"",
    slug: json["slug"]??"",
    categoryId: json["category_id"]??"",
    thumbnailImg: json["thumbnail_img"]??"",
    bannerImg: json["banner_img"]??"",
    status: json["status"]??"",
    approved: json["approved"]??"",
    sticky: json["sticky"]??"",
    description: json["description"]??"",
    position: json["position"]??"",
    isFeatured: json["is_featured"]??"",
    createdAt: json["created_at"]!=null? DateTime.parse(json["created_at"]):DateTime.now(),
    updatedAt: json["updated_at"]!=null? DateTime.parse(json["updated_at"]):DateTime.now(),
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



class BlogComments implements BaseCommentModel{
  int id;
  String name;
  int userId;
  String email;
  int blogId;
  String comment;
  DateTime createdAt;
  DateTime updatedAt;

  BlogComments({
    required this.id,
    required this.name,
    required this.userId,
    required this.email,
    required this.blogId,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogComments.fromJson(Map<String, dynamic> json) => BlogComments(
    id: json["id"]??"",
    name: json["name"]??"",
    userId: json["user_id"]??"",
    email: json["email"]??"",
    blogId: json["blog_id"]??"",
    comment: json["comment"]??"",
    createdAt:  json["create_at"]!=null?DateTime.parse(json["created_at"]):DateTime.now(),
    updatedAt:  json["update_at"] !=null ? DateTime.parse(json["updated_at"]):DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "user_id": userId,
    "email": email,
    "blog_id": blogId,
    "comment": comment,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
