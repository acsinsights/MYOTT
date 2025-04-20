

import 'dart:convert';

import '../../../Core/Utils/app_common.dart';

class MediaItem {
  final int id;
  final String name;
  final String imageUrl;
  final String slug;
  final MediaType type;

  MediaItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.slug,
    required this.type,
  });
}


class LatestMandTModel {
  List<latestMovie> movies;
  List<latestSeries> series;

  LatestMandTModel({
    required this.movies,
    required this.series,
  });

  factory LatestMandTModel.fromJson(Map<String, dynamic> json) => LatestMandTModel(
    movies: List<latestMovie>.from(json["movies"].map((x) => latestMovie.fromJson(x))),
    series: List<latestSeries>.from(json["series"].map((x) => latestSeries.fromJson(x))),
  );


}

class latestMovie {
  int id;
  String name;
  String slug;
  String posterImg;
  String thumbnailImg;
  final String contentType;
  latestMovie({
    required this.id,
    required this.name,
    required this.slug,
    required this.posterImg,
    required this.thumbnailImg,
    this.contentType = "movie",
  });

  factory latestMovie.fromJson(Map<String, dynamic> json) => latestMovie(
    id: json["id"]??0,

    name: json["name"]??"",
    slug: json["slug"]??"",
    posterImg: json["poster_img"]??"",
    thumbnailImg: json["thumbnail_img"]??"",
  );
}

class Actor {
  int id;
  String name;
  String slug;
  String image;
  String? type;
  String description;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  Actor({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    this.type,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
    type: json["type"],
    description: json["description"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "image": image,
    "type": type,
    "description": description,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Package {
  bool free;
  String? selection;
  int coinCost;
  int? planPrice;
  int? offerPrice;

  Package({
    required this.free,
    required this.selection,
    required this.coinCost,
    required this.planPrice,
    required this.offerPrice,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    free: json["free"] ?? false,
    selection: json["selection"]?.toString() ?? "",
    coinCost: (json["coin_cost"] ?? 0),
    planPrice: (json["plan_price"] ?? 0),
    offerPrice: (json["offer_price"] ?? 0),
  );

  Map<String, dynamic> toJson() => {
    "free": free,
    "selection": selection,
    "coin_cost": coinCost,
    "plan_price": planPrice,
    "offer_price": offerPrice,
  };
}

class SeriesPackage {
  int id;
  int seriesId;
  bool free; // ✅ Changed from int to bool
  String selection;
  int coinCost;
  int planPrice;
  int offerPrice;

  SeriesPackage({
    required this.id,
    required this.seriesId,
    required this.free,
    required this.selection,
    required this.coinCost,
    required this.planPrice,
    required this.offerPrice,
  });

  factory SeriesPackage.fromJson(Map<String, dynamic> json) => SeriesPackage(
    id: json["id"] ?? 0,
    seriesId: json["series_id"] ?? 0,
    free: json["free"] == 1, // ✅ Convert 1 → true, 0 → false
    selection: json["selection"]?.toString() ?? "",
    coinCost: json["coin_cost"] ?? 0,
    planPrice: json["plan_price"] ?? 0,
    offerPrice: json["offer_price"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "series_id": seriesId,
    "free": free ? 1 : 0, // ✅ Convert bool back to int (true → 1, false → 0)
    "selection": selection,
    "coin_cost": coinCost,
    "plan_price": planPrice,
    "offer_price": offerPrice,
  };
}

class latestSeries {
  int id;
  String name;
  String slug;
  String thumbnailImg;

  final String contentType; // "series"

  latestSeries({
    required this.id,

    required this.name,
    required this.slug,
    required this.thumbnailImg,

    this.contentType = "series", // Default type as "series"


  });

  factory latestSeries.fromJson(Map<String, dynamic> json) => latestSeries(
    id: json["id"] ?? 0,
    name: json["name"]?.toString() ?? "",
    slug: json["slug"]?.toString() ?? "",
    thumbnailImg: json["thumbnail_img"]?.toString() ?? "",
  );

}

