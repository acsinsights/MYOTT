// To parse this JSON data, do
//
//     final tvSeriesModel = tvSeriesModelFromJson(jsonString);

import 'dart:convert';


class TvSeriesModel {
  int id;
  String name;
  String slug;
  String thumbnailImg;
  int audioLanguage;
  String maturity;
  String trailerUrl;
  String description;
  bool subAvailable;
  bool dubAvailable;
  String seriesUploadType;
  String releaseYear;
  int views;
  int fakeViews;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> genre;
  List<String> actors;
  List<String> directors;
  List<String> regionRestrictions;
  MetaData? metaData;
  List<Episode> episodes;

  TvSeriesModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.thumbnailImg,
    required this.audioLanguage,
    required this.maturity,
    required this.trailerUrl,
    required this.description,
    required this.subAvailable,
    required this.dubAvailable,
    required this.seriesUploadType,
    required this.releaseYear,
    required this.views,
    required this.fakeViews,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.genre,
    required this.actors,
    required this.directors,
    required this.regionRestrictions,
    required this.metaData,
    required this.episodes,
  });

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    thumbnailImg: json["thumbnail_img"],
    audioLanguage: json["audio_language"],
    maturity: json["maturity"],
    trailerUrl: json["trailer_url"],
    description: json["description"],
    subAvailable: json["sub_available"],
    dubAvailable: json["dub_available"],
    seriesUploadType: json["series_upload_type"],
    releaseYear: json["release_year"],
    views: json["views"],
    fakeViews: json["fake_views"],

    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    genre: List<String>.from(json["genre"].map((x) => x)),
    actors: List<String>.from(json["actors"].map((x) => x)),
    directors: List<String>.from(json["directors"].map((x) => x)),
    regionRestrictions: List<String>.from(json["region_restrictions"].map((x) => x)),
    metaData: json["meta_data"] == null ? null : MetaData.fromJson(json["meta_data"]),
    episodes: List<Episode>.from(json["episodes"].map((x) => Episode.fromJson(x))),
  );

}

class Episode {
  int id;
  int seriesId;
  int episodeNumber;
  String title;
  String description;
  String posterImage;
  String uploadUrl;
  String? uploadFiles;
  bool episodeFree;
  DateTime createdAt;
  DateTime updatedAt;

  Episode({
    required this.id,
    required this.seriesId,
    required this.episodeNumber,
    required this.title,
    required this.description,
    required this.posterImage,
    required this.uploadUrl,
    required this.uploadFiles,
    required this.episodeFree,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
    id: json["id"],
    seriesId: json["series_id"],
    episodeNumber: json["episode_number"],
    title: json["title"],
    description: json["description"],
    posterImage: json["poster_image"],
    uploadUrl: json["upload_url"],
    uploadFiles: json["upload_files"],
    episodeFree: json["episode_free"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "series_id": seriesId,
    "episode_number": episodeNumber,
    "title": title,
    "description": description,
    "poster_image": posterImage,
    "upload_url": uploadUrl,
    "upload_files": uploadFiles,
    "episode_free": episodeFree,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class MetaData {
  String metaTitle;
  List<String> metaKeywords;
  String metaDescription;
  String metaImage;

  MetaData({
    required this.metaTitle,
    required this.metaKeywords,
    required this.metaDescription,
    required this.metaImage,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
    metaTitle: json["meta_title"],
    metaKeywords: List<String>.from(json["meta_keywords"].map((x) => x)),
    metaDescription: json["meta_description"],
    metaImage: json["meta_image"],
  );

  Map<String, dynamic> toJson() => {
    "meta_title": metaTitle,
    "meta_keywords": List<dynamic>.from(metaKeywords.map((x) => x)),
    "meta_description": metaDescription,
    "meta_image": metaImage,
  };
}
