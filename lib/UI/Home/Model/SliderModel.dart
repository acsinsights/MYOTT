// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

List<SliderModel> sliderModelFromJson(String str) => List<SliderModel>.from(json.decode(str).map((x) => SliderModel.fromJson(x)));

String sliderModelToJson(List<SliderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SliderModel {
  int id;
  Content content;

  SliderModel({
    required this.id,
    required this.content,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    id: json["id"],
    content: Content.fromJson(json["content"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content.toJson(),
  };
}

class Content {
  int id;
  String? movieUploadType;
  String? movieUploadUrl;
  dynamic movieUploadFiles;
  String name;
  String slug;
  String? posterImg;
  String? thumbnailImg;
  int audioLanguage;
  String maturity;
  String? trailerUrl;
  String? releaseYear;
  int views;
  int fakeViews;
  String description;
  DateTime? scheduleDate;
  String? scheduleTime;
  int status;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String? videoUploadType;
  String? videoUploadUrl;
  dynamic videoUploadFiles;
  String? image;

  Content({
    required this.id,
    this.movieUploadType,
    this.movieUploadUrl,
    this.movieUploadFiles,
    required this.name,
    required this.slug,
    this.posterImg,
    this.thumbnailImg,
    required this.audioLanguage,
    required this.maturity,
    this.trailerUrl,
    this.releaseYear,
    required this.views,
    required this.fakeViews,
    required this.description,
    required this.scheduleDate,
    required this.scheduleTime,
    required this.status,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.videoUploadType,
    this.videoUploadUrl,
    this.videoUploadFiles,
    this.image,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    id: json["id"],
    movieUploadType: json["movie_upload_type"],
    movieUploadUrl: json["movie_upload_url"],
    movieUploadFiles: json["movie_upload_files"],
    name: json["name"],
    slug: json["slug"],
    posterImg: json["poster_img"],
    thumbnailImg: json["thumbnail_img"],
    audioLanguage: json["audio_language"],
    maturity: json["maturity"],
    trailerUrl: json["trailer_url"],
    releaseYear: json["release_year"],
    views: json["views"],
    fakeViews: json["fake_views"],
    description: json["description"],
    scheduleDate: json["schedule_date"] == null ? null : DateTime.parse(json["schedule_date"]),
    scheduleTime: json["schedule_time"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    videoUploadType: json["video_upload_type"],
    videoUploadUrl: json["video_upload_url"],
    videoUploadFiles: json["video_upload_files"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "movie_upload_type": movieUploadType,
    "movie_upload_url": movieUploadUrl,
    "movie_upload_files": movieUploadFiles,
    "name": name,
    "slug": slug,
    "poster_img": posterImg,
    "thumbnail_img": thumbnailImg,
    "audio_language": audioLanguage,
    "maturity": maturity,
    "trailer_url": trailerUrl,
    "release_year": releaseYear,
    "views": views,
    "fake_views": fakeViews,
    "description": description,
    "schedule_date": "${scheduleDate!.year.toString().padLeft(4, '0')}-${scheduleDate!.month.toString().padLeft(2, '0')}-${scheduleDate!.day.toString().padLeft(2, '0')}",
    "schedule_time": scheduleTime,
    "status": status,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "video_upload_type": videoUploadType,
    "video_upload_url": videoUploadUrl,
    "video_upload_files": videoUploadFiles,
    "image": image,
  };
}
