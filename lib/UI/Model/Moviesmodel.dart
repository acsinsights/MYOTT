import 'dart:convert';

MoviesModel moviesModelFromJson(String str) => MoviesModel.fromJson(json.decode(str));

String moviesModelToJson(MoviesModel data) => json.encode(data.toJson());

class MoviesModel {
  final int id;
  final String name;
  final String slug;
  final String posterImg;
  final String thumbnailImg;
  final String trailerUrl;
  final String releaseYear;
  final String description;
  final List<Actor> directors;

  final PackageClass? package;
  MoviesModel({
    required this.id,

    required this.name,
    required this.slug,
    required this.posterImg,
    required this.thumbnailImg,
required this.description,
    required this.trailerUrl,
    required this.releaseYear,
    required this.directors,

    required this.package,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
    id: json["id"] ?? 0,

    name: json["name"] ?? "",
    slug: json["slug"] ?? "",
    description: json["description"] ?? "",
    posterImg: json["poster_img"] ?? "",
    thumbnailImg: json["thumbnail_img"] ?? "",

    trailerUrl: json["trailer_url"] ?? "",
    releaseYear: json["release_year"] ?? "",


    directors: (json["directors"] as List?)?.map((x) => Actor.fromJson(x)).toList() ?? [],

    // ✅ Correctly parsing `package` as an object
    package: json["package"] != null ? PackageClass.fromJson(json["package"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,

    "name": name,
    "slug": slug,
    "poster_img": posterImg,
    "thumbnail_img": thumbnailImg,

    "trailer_url": trailerUrl,
    "release_year": releaseYear,

    "directors": directors,

  };
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

class PackageClass {
  bool free;
  String selection;
  int coinCost;
  int planPrice;
  int offerPrice;

  PackageClass({
    required this.free,
    required this.selection,
    required this.coinCost,
    required this.planPrice,
    required this.offerPrice,
  });

  factory PackageClass.fromJson(Map<String, dynamic> json) => PackageClass(
    free: json["free"] ?? false,
    selection: json["selection"]?.toString() ?? "",
    coinCost: (json["coin_cost"] ?? 1),
    planPrice: (json["plan_price"] ?? 1),
    offerPrice: (json["offer_price"] ?? 1),
  );

  Map<String, dynamic> toJson() => {
    "free": free,
    "selection": selection,
    "coin_cost": coinCost,
    "plan_price": planPrice,
    "offer_price": offerPrice,
  };
}
