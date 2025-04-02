// To parse this JSON data, do
//
//     final videoDetailsModel = videoDetailsModelFromJson(jsonString);

import 'dart:convert';

VideoDetailsModel videoDetailsModelFromJson(String str) => VideoDetailsModel.fromJson(json.decode(str));

String videoDetailsModelToJson(VideoDetailsModel data) => json.encode(data.toJson());

class VideoDetailsModel {
  int id;
  String videoUploadType;
  String videoUploadUrl;
  dynamic videoUploadFiles;
  String name;
  String slug;
  String thumbnailImg;
  int audioLanguage;
  String maturity;
  dynamic trailerUrl;
  DateTime releaseYear;
  int views;
  int fakeViews;
  String durationTime;
  String description;
  dynamic scheduleDate;
  dynamic scheduleTime;
  int status;
  Cast cast;

  VideoDetailsModel({
    required this.id,
    required this.videoUploadType,
    required this.videoUploadUrl,
    required this.videoUploadFiles,
    required this.name,
    required this.slug,
    required this.thumbnailImg,
    required this.audioLanguage,
    required this.maturity,
    required this.trailerUrl,
    required this.releaseYear,
    required this.views,
    required this.fakeViews,
    required this.durationTime,
    required this.description,
    required this.scheduleDate,
    required this.scheduleTime,
    required this.status,
    required this.cast,
  });

  factory VideoDetailsModel.fromJson(Map<String, dynamic> json) => VideoDetailsModel(
    id: (json["id"]??0),
    videoUploadType: json["video_upload_type"]?.toString()?? "",
    videoUploadUrl: json["video_upload_url"]?.toString() ?? "",
    videoUploadFiles: json["video_upload_files"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
    slug: json["slug"]?.toString() ?? "",
    thumbnailImg: json["thumbnail_img"]?.toString() ?? "",
    audioLanguage: json["audio_language"],
    maturity: json["maturity"]?.toString() ?? "",
    trailerUrl: json["trailer_url"]?.toString() ?? "",
    releaseYear: DateTime.parse(json["release_year"]),
    views: (json["views"]??0),
    fakeViews: (json["fake_views"]??0),
    durationTime: json["duration_time"]?.toString() ?? "",
    description: json["description"]?.toString() ?? "",
    scheduleDate: json["schedule_date"]?.toString() ?? "",
    scheduleTime: json["schedule_time"]?.toString() ?? "",
    status: json["status"],
    cast: Cast.fromJson(json["cast"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "video_upload_type": videoUploadType,
    "video_upload_url": videoUploadUrl,
    "video_upload_files": videoUploadFiles,
    "name": name,
    "slug": slug,
    "thumbnail_img": thumbnailImg,
    "audio_language": audioLanguage,
    "maturity": maturity,
    "trailer_url": trailerUrl,
    "release_year": "${releaseYear.year.toString().padLeft(4, '0')}-${releaseYear.month.toString().padLeft(2, '0')}-${releaseYear.day.toString().padLeft(2, '0')}",
    "views": views,
    "fake_views": fakeViews,
    "duration_time": durationTime,
    "description": description,
    "schedule_date": scheduleDate,
    "schedule_time": scheduleTime,
    "status": status,
    "cast": cast.toJson(),
  };
}

class Cast {
  List<Actor> actors;
  List<Actor> directors;
  List<Actor> genres;

  Cast({
    required this.actors,
    required this.directors,
    required this.genres,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
    actors: json["actors"]!=null?  List<Actor>.from(json["actors"].map((x) => Actor.fromJson(x))) :[],
    directors: json["directors"]!=null? List<Actor>.from(json["directors"].map((x) => Actor.fromJson(x))):[],
    genres: json["genres"]!=null ?List<Actor>.from(json["genres"].map((x) => Actor.fromJson(x))):[],
  );

  Map<String, dynamic> toJson() => {
    "actors": List<dynamic>.from(actors.map((x) => x.toJson())),
    "directors": List<dynamic>.from(directors.map((x) => x.toJson())),
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
  };
}

class Actor {
  int id;
  String name;
  String image;

  Actor({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    image: json["image"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
