

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

  factory LatestMandTModel.fromJson(Map<String, dynamic> json) {
    final latest = json['latest'] as Map<String, dynamic>?;

    return LatestMandTModel(
      movies: (latest?['movies'] as List<dynamic>? ?? [])
          .map((e) => latestMovie.fromJson(e as Map<String, dynamic>))
          .toList(),
      series: (latest?['series'] as List<dynamic>? ?? [])
          .map((e) => latestSeries.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }




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

