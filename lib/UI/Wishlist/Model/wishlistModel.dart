import 'dart:convert';

WishlistModel wishlistModelFromJson(String str) => WishlistModel.fromJson(json.decode(str));

String wishlistModelToJson(WishlistModel data) => json.encode(data.toJson());

class WishlistModel {
  int id;
  int userId;
  int added;
  DateTime createdAt;
  DateTime updatedAt;
  Movie movie;
  Series series;

  WishlistModel({
    required this.id,
    required this.userId,
    required this.added,
    required this.createdAt,
    required this.updatedAt,
    required this.movie,
    required this.series,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
    id: json["id"] ?? 0,
    userId: json["user_id"] ?? 0,
    added: json["added"] ?? 0,
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime.now(),
    movie: json["movie"] != null ? Movie.fromJson(json["movie"]) : Movie.empty(), // Handle null movie
    series: json["series"] !=null ? Series.fromJson(json["series"]): Series.empty(),  // Handle series as nullable
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "added": added,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "movie": movie.toJson(),
    "series": series,
  };
}

class Movie {
  int id;
  String name;
  String thumbnailImg;
  String slug;

  Movie({
    required this.id,
    required this.name,
    required this.thumbnailImg,
    required this.slug,
  });

  /// Factory constructor to create an empty Movie instance
  factory Movie.empty() => Movie(name: "", thumbnailImg: "", slug: "",id: 0);

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json["id"]??"",
    name: json["name"] ?? "", // Default to empty string if null
    thumbnailImg: json["thumbnail_img"] ?? "",
    slug: json["slug"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "thumbnail_img": thumbnailImg,
    "slug": slug,
  };
}
class Series {
  int id;
  String name;
  String thumbnailImg;
  String slug;

  Series({
    required this.id,
    required this.name,
    required this.thumbnailImg,
    required this.slug,
  });

  /// Factory constructor to create an empty Movie instance
  factory Series.empty() => Series(name: "", thumbnailImg: "", slug: "",id: 0);

  factory Series.fromJson(Map<String, dynamic> json) => Series(
    id: json["id"]??0,
    name: json["name"] ?? "", // Default to empty string if null
    thumbnailImg: json["thumbnail_img"] ?? "",
    slug: json["slug"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "thumbnail_img": thumbnailImg,
    "slug": slug,
  };
}

