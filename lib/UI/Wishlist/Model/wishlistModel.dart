import 'dart:convert';

WishlistModel wishlistModelFromJson(String str) => WishlistModel.fromJson(json.decode(str));

String wishlistModelToJson(WishlistModel data) => json.encode(data.toJson());

class WishlistModel {
  int id;
  int userId;
  int added;
  DateTime createdAt;
  DateTime updatedAt;
  WishlistMovie movie;
  WishlistSeries series;
  WishlistAudio audio;
  WishlistVideo video;

  WishlistModel({
    required this.id,
    required this.userId,
    required this.added,
    required this.createdAt,
    required this.updatedAt,
    required this.movie,
    required this.series,
    required this.audio,
    required this.video,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
    id: json["id"] ?? 0,
    userId: json["user_id"] ?? 0,
    added: json["added"] ?? 0,
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime.now(),
    movie: json["movie"] != null ? WishlistMovie.fromJson(json["movie"]) : WishlistMovie.empty(), // Handle null movie
    series: json["series"] !=null ? WishlistSeries.fromJson(json["series"]): WishlistSeries.empty(),  // Handle series as nullable
    audio: json["audio"] !=null ? WishlistAudio.fromJson(json["audio"]): WishlistAudio.empty(),  // Handle series as nullable
    video: json["video"] !=null ? WishlistVideo.fromJson(json["video"]): WishlistVideo.empty(),

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



class WishlistMovie {
  int id;
  String name;
  String thumbnailImg;
  String slug;

  WishlistMovie({
    required this.id,
    required this.name,
    required this.thumbnailImg,
    required this.slug,
  });

  /// Factory constructor to create an empty Movie instance
  factory WishlistMovie.empty() => WishlistMovie(name: "", thumbnailImg: "", slug: "",id: 0);

  factory WishlistMovie.fromJson(Map<String, dynamic> json) => WishlistMovie(
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
class WishlistSeries {
  int id;
  String name;
  String thumbnailImg;
  String slug;

  WishlistSeries({
    required this.id,
    required this.name,
    required this.thumbnailImg,
    required this.slug,
  });

  /// Factory constructor to create an empty Movie instance
  factory WishlistSeries.empty() => WishlistSeries(name: "", thumbnailImg: "", slug: "",id: 0);

  factory WishlistSeries.fromJson(Map<String, dynamic> json) => WishlistSeries(
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
class WishlistVideo {
  int id;
  String name;
  String thumbnailImg;
  String slug;

  WishlistVideo({
    required this.id,
    required this.name,
    required this.thumbnailImg,
    required this.slug,
  });

  /// Factory constructor to create an empty Movie instance
  factory WishlistVideo.empty() => WishlistVideo(name: "", thumbnailImg: "", slug: "",id: 0);

  factory WishlistVideo.fromJson(Map<String, dynamic> json) => WishlistVideo(
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

class WishlistAudio {
  int id;
  String name;
  String thumbnailImg;
  String slug;

  WishlistAudio({
    required this.id,
    required this.name,
    required this.thumbnailImg,
    required this.slug,
  });

  factory WishlistAudio.empty() => WishlistAudio(name: "", thumbnailImg: "", slug: "",id: 0);

  factory WishlistAudio.fromJson(Map<String, dynamic> json) => WishlistAudio(
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


