// To parse this JSON data, do
//
//     final LanguageDetailsResponseModel = AudioDeatilsResponseModelFromJson(jsonString);

import 'dart:convert';

import '../../../Core/Utils/app_common.dart';


class LanguageDetailsResponseModel {
  List<AuidoMovie> movies;
   List<AudioSeries> series;
  List<AudioVideo> videos;
  List<Audio> audio;

  LanguageDetailsResponseModel({
    required this.movies,
     required this.series,
    required this.videos,
    required this.audio,
  });

  factory LanguageDetailsResponseModel.fromJson(Map<String, dynamic> json) => LanguageDetailsResponseModel(
    movies: (json["movies"] as List?)?.map((x) => AuidoMovie.fromJson(x)).toList() ?? [],
    series: (json["tv_series"] as List?)?.map((x) => AudioSeries.fromJson(x)).toList() ?? [],
    videos: (json["videos"] as List?)?.map((x) => AudioVideo.fromJson(x)).toList() ?? [],
    audio: (json["audio"] as List?)?.map((x) => Audio.fromJson(x)).toList() ?? [],
  );


  Map<String, dynamic> toJson() => {
    "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
    "tv_series": List<dynamic>.from(series.map((x) => x)),
    "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
    "audio": List<dynamic>.from(audio.map((x) => x.toJson())),
  };
}

class AuidoMovie {
  int id;
  String name;
  String slug;
  String? posterImg;
  final String contentType;
  String thumbnailImg;


  AuidoMovie({
    required this.id,
    this.contentType="movie",

    required this.name,
    required this.slug,
    this.posterImg,
    required this.thumbnailImg,
  });

  factory AuidoMovie.fromJson(Map<String, dynamic> json) => AuidoMovie(
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
class AudioSeries {
  int id;
  String name;
  String slug;
  String thumbnailImg;
  final String contentType; // "series"

  AudioSeries({
    required this.id,
    required this.name,
    required this.slug,
    required this.thumbnailImg,
    this.contentType = "series", // Default type as "series"
  });

  factory AudioSeries.fromJson(Map<String, dynamic> json) => AudioSeries(
    id: json["id"] ?? 0,

    name: json["name"]?.toString() ?? "",
    slug: json["slug"]?.toString() ?? "",
    thumbnailImg: json["thumbnail_img"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "thumbnail_img": thumbnailImg,
    "content_type": contentType, // Include type in JSON
  };
}
class AudioVideo {
  int id;
  String name;
  String slug;
  String? posterImg;
  final String contentType;
  String thumbnailImg;


  AudioVideo({
    required this.id,
    this.contentType="movie",

    required this.name,
    required this.slug,
    this.posterImg,
    required this.thumbnailImg,
  });

  factory AudioVideo.fromJson(Map<String, dynamic> json) => AudioVideo(
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
