// To parse this JSON data, do
//
//     final mandTAudioModel = mandTAudioModelFromJson(jsonString);

import 'dart:convert';

import '../../../Core/Utils/app_common.dart';

MandTAudioModel mandTAudioModelFromJson(String str) => MandTAudioModel.fromJson(json.decode(str));

String mandTAudioModelToJson(MandTAudioModel data) => json.encode(data.toJson());

class AudioItem {
  final int id;
  final String name;
  final String imageUrl;
  final String slug;
  final MediaType type;
  final bool isfree;

  AudioItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.slug,
    required this.type,
    required this.isfree
  });
}


class MandTAudioModel {
  List<Movie> movies;
  // List<Series> series;
  List<Video> videos;
  List<Audio> audio;

  MandTAudioModel({
    required this.movies,
    // required this.series,
    required this.videos,
    required this.audio,
  });

  factory MandTAudioModel.fromJson(Map<String, dynamic> json) => MandTAudioModel(
    movies: List<Movie>.from(json["movies"].map((x) => Movie.fromJson(x))??{}),
    // series: List<Series>.from(json["tv_series"].map((x) => x)),
    videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))??{}),
    audio: List<Audio>.from(json["audio"].map((x) => Audio.fromJson(x))??{}),
  );

  Map<String, dynamic> toJson() => {
    "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
    // "tv_series": List<dynamic>.from(series.map((x) => x)),
    "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
    "audio": List<dynamic>.from(audio.map((x) => x.toJson())),
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
    "content_type": contentType, // Include type in JSON
    "series_package": seriesPackage?.toJson(),
  };
}


class Audio {
  int id;
  String name;
  String slug;
  String thumbnailImg;
  final String contentType;


  Audio({
    required this.id,
  this.contentType="audio",
    required this.name,
    required this.slug,
    required this.thumbnailImg,

  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
    id: json["id"]??0,

    name: json["name"]??"",
    slug: json["slug"]??"",
    thumbnailImg: json["thumbnail_img"]??"",

  );

  Map<String, dynamic> toJson() => {
    "id": id,

    "name": name,
    "slug": slug,
    "thumbnail_img": thumbnailImg,

  };
}

class Movie {
  int id;
  String name;
  String slug;
  String? posterImg;
  final String contentType;
  String thumbnailImg;


  Movie({
    required this.id,
    this.contentType="movie",

    required this.name,
    required this.slug,
    this.posterImg,
    required this.thumbnailImg,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json["id"]??0,

    name: json["name"]??"",
    slug: json["slug"]??"",
    posterImg: json["poster_img"]??"",
    thumbnailImg: json["thumbnail_img"]??"",

  );

  Map<String, dynamic> toJson() => {
    "id": id,

    "name": name,
    "slug": slug,
    "poster_img": posterImg,
    "thumbnail_img": thumbnailImg,

  };
}
class Video {
  int id;
  String name;
  String slug;
  String? posterImg;
  final String contentType;
  String thumbnailImg;


  Video({
    required this.id,
    this.contentType="movie",

    required this.name,
    required this.slug,
    this.posterImg,
    required this.thumbnailImg,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"]??0,

    name: json["name"]??"",
    slug: json["slug"]??"",
    posterImg: json["poster_img"]??"",
    thumbnailImg: json["thumbnail_img"]??"",

  );

  Map<String, dynamic> toJson() => {
    "id": id,

    "name": name,
    "slug": slug,
    "poster_img": posterImg,
    "thumbnail_img": thumbnailImg,

  };
}
