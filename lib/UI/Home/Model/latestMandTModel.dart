

import 'dart:convert';
enum MediaType { movie, series }

class MediaItem {
  final int id;
  final String name;
  final String imageUrl;
  final String slug;
  final MediaType type;
  final bool isfree;

  MediaItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.slug,
    required this.type,
    required this.isfree
  });
}

LatestMandTModel latestMandTModelFromJson(String str) => LatestMandTModel.fromJson(json.decode(str));

String latestMandTModelToJson(LatestMandTModel data) => json.encode(data.toJson());

class LatestMandTModel {
  List<Movie> movies;
  List<Series> series;

  LatestMandTModel({
    required this.movies,
    required this.series,
  });

  factory LatestMandTModel.fromJson(Map<String, dynamic> json) => LatestMandTModel(
    movies: List<Movie>.from(json["movies"].map((x) => Movie.fromJson(x))),
    series: List<Series>.from(json["series"].map((x) => Series.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
    "series": List<dynamic>.from(series.map((x) => x.toJson())),
  };
}

class Movie {
  int id;
  String movieUploadType;
  String movieUploadUrl;
  String name;
  String slug;
  String posterImg;
  String thumbnailImg;
  int audioLanguage;
  String maturity;
  String trailerUrl;
  DateTime releaseYear;
  String description;
  String duration;
  final String contentType;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  List<Actor> directors;
  List<Actor> actors;
  List<Actor> genre;
  Package package;

  Movie({
    required this.id,
    required this.movieUploadType,
    required this.movieUploadUrl,
    required this.name,
    required this.slug,
    required this.posterImg,
    required this.thumbnailImg,
    required this.audioLanguage,
    required this.maturity,
    required this.trailerUrl,
    required this.releaseYear,
    required this.description,
    required this.duration,
    this.contentType = "movie",

    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.directors,
    required this.actors,
    required this.genre,
    required this.package,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json["id"],
    movieUploadType: json["movie_upload_type"],
    movieUploadUrl: json["movie_upload_url"],
    name: json["name"],
    slug: json["slug"],
    posterImg: json["poster_img"],
    thumbnailImg: json["thumbnail_img"],
    audioLanguage: json["audio_language"],
    maturity: json["maturity"],
    trailerUrl: json["trailer_url"],
    releaseYear: DateTime.parse(json["release_year"]),
    description: json["description"],
    duration: json["duration"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    directors: List<Actor>.from(json["directors"].map((x) => Actor.fromJson(x))),
    actors: List<Actor>.from(json["actors"].map((x) => Actor.fromJson(x))),
    genre: List<Actor>.from(json["genre"].map((x) => Actor.fromJson(x))),
    package: Package.fromJson(json["package"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "movie_upload_type": movieUploadType,
    "movie_upload_url": movieUploadUrl,
    "name": name,
    "slug": slug,
    "poster_img": posterImg,
    "thumbnail_img": thumbnailImg,
    "audio_language": audioLanguage,
    "maturity": maturity,
    "trailer_url": trailerUrl,
    "release_year": "${releaseYear.year.toString().padLeft(4, '0')}-${releaseYear.month.toString().padLeft(2, '0')}-${releaseYear.day.toString().padLeft(2, '0')}",
    "description": description,
    "duration": duration,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "directors": List<dynamic>.from(directors.map((x) => x.toJson())),
    "actors": List<dynamic>.from(actors.map((x) => x.toJson())),
    "genre": List<dynamic>.from(genre.map((x) => x.toJson())),
    "package": package.toJson(),
    "content_type": contentType, // Include type in JSON

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
  bool free;
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
    id: (json["id"]?? 0),
    seriesId: (json["series_id"]??0),
    free: json["free"] ?? false,
    selection: json["selection"]?.toString() ?? "",
    coinCost: (json["coin_cost"] ?? 0),
    planPrice: (json["plan_price"] ?? 0),
    offerPrice: (json["offer_price"] ?? 0),

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "series_id": seriesId,
    "free": free,
    "selection": selection,
    "coin_cost": coinCost,
    "plan_price": planPrice,
    "offer_price": offerPrice,

  };
}

class Series {
  int id;
  String seriesUploadType;
  String name;
  String slug;
  String thumbnailImg;
  int audioLanguage;
  String maturity;
  String trailerUrl;
  DateTime releaseYear;
  String description;
  int status;
  List<Actor> directors;
  List<Actor> actors;
  SeriesPackage? seriesPackage;
  final String contentType; // "series"

  Series({
    required this.id,
    required this.seriesUploadType,

    required this.name,
    required this.slug,
    required this.thumbnailImg,
    required this.audioLanguage,
    required this.maturity,
    required this.trailerUrl,
    required this.releaseYear,
    required this.description,
    this.contentType = "series", // Default type as "series"

    required this.status,

    required this.directors,
    required this.actors,
    required this.seriesPackage,
  });

  factory Series.fromJson(Map<String, dynamic> json) => Series(
    id: json["id"] ?? 0,
    seriesUploadType: json["series_upload_type"] ?? 0,
    name: json["name"]?.toString() ?? "",
    slug: json["slug"]?.toString() ?? "",
    thumbnailImg: json["thumbnail_img"]?.toString() ?? "",
    audioLanguage: json["audio_language"], // Nullable
    maturity: json["maturity"]?.toString() ?? "",
    trailerUrl: json["trailer_url"]?.toString() ?? "",
    releaseYear: DateTime.parse(json["release_year"]),
    description: json["description"]?.toString() ?? "",
    status: json["status"] ?? 0, // Default to 0 if null
    directors: (json["directors"] as List?)?.map((x) => Actor.fromJson(x)).toList() ?? [],
    actors: (json["actors"] as List?)?.map((x) => Actor.fromJson(x)).toList() ?? [],
    seriesPackage: json["series_package"] != null ? SeriesPackage.fromJson(json["series_package"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "series_upload_type": seriesUploadType,
    "name": name,
    "slug": slug,
    "thumbnail_img": thumbnailImg,
    "audio_language": audioLanguage,
    "maturity": maturity,
    "trailer_url": trailerUrl,
    "release_year": "${releaseYear.year.toString().padLeft(4, '0')}-${releaseYear.month.toString().padLeft(2, '0')}-${releaseYear.day.toString().padLeft(2, '0')}",
    "description": description,

    "status": status,
    "content_type": contentType, // Include type in JSON

    "directors": List<dynamic>.from(directors.map((x) => x.toJson())),
    "actors": List<dynamic>.from(actors.map((x) => x.toJson())),
    "series_package": seriesPackage?.toJson(),
  };
}

