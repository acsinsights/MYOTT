// To parse this JSON data, do
//
//     final pageModel = pageModelFromJson(jsonString);

import 'dart:convert';

PageModel pageModelFromJson(String str) => PageModel.fromJson(json.decode(str));

String pageModelToJson(PageModel data) => json.encode(data.toJson());

class PageModel {
  List<CustomPage> pages;

  PageModel({
    required this.pages,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) => PageModel(
    pages: List<CustomPage>.from(json["Pages"].map((x) => CustomPage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Pages": List<dynamic>.from(pages.map((x) => x.toJson())),
  };
}

class CustomPage {
  int id;
  String title;
  String description;
  String slug;
  String pageLink;
  DateTime createdAt;
  DateTime updatedAt;

  CustomPage({
    required this.id,
    required this.title,
    required this.description,
    required this.slug,
    required this.pageLink,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomPage.fromJson(Map<String, dynamic> json) => CustomPage(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    slug: json["slug"],
    pageLink: json["page_link"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "slug": slug,
    "page_link": pageLink,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
