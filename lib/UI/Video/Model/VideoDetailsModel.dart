// To parse this JSON data, do
//
//     final videoDetailsModel = videoDetailsModelFromJson(jsonString);

import 'dart:convert';

class VideoDetailsModel {
  int id;
  String videoUploadType;
  String videoUploadUrl;
  String name;
  String slug;
  String thumbnailImg;
  int audioLanguage;
  String maturity;
  String trailerUrl;
  DateTime releaseYear;
  int views;
  int fakeViews;
  String durationTime;
  String description;
  int status;
  VideoCast cast;

  VideoDetailsModel({
    required this.id,
    required this.videoUploadType,
    required this.videoUploadUrl,
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

    required this.status,
    required this.cast,
  });

  factory VideoDetailsModel.fromJson(Map<String, dynamic> json) => VideoDetailsModel(
    id: (json["id"]??0),
    videoUploadType: json["video_upload_type"]?.toString()?? "",
    videoUploadUrl: json["video_upload_url"]?.toString() ?? "",
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
    status: json["status"],
    cast: VideoCast.fromJson(json["cast"]),
  );

}

class VideoCast {
  List<VideoActor> actors;
  List<VideoActor> directors;
  List<VideoActor> genres;

  VideoCast({
    required this.actors,
    required this.directors,
    required this.genres,
  });

  factory VideoCast.fromJson(Map<String, dynamic> json) => VideoCast(
    actors: json["actors"]!=null?  List<VideoActor>.from(json["actors"].map((x) => VideoActor.fromJson(x))) :[],
    directors: json["directors"]!=null? List<VideoActor>.from(json["directors"].map((x) => VideoActor.fromJson(x))):[],
    genres: json["genres"]!=null ?List<VideoActor>.from(json["genres"].map((x) => VideoActor.fromJson(x))):[],
  );

}

class VideoActor {
  int id;
  String name;
  String image;

  VideoActor({
    required this.id,
    required this.name,
    required this.image,
  });

  factory VideoActor.fromJson(Map<String, dynamic> json) => VideoActor(
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
