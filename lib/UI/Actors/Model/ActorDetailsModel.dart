// To parse this JSON data, do
//
//     final actorDetailsModel = actorDetailsModelFromJson(jsonString);

import 'dart:convert';

ActorDetailsModel actorDetailsModelFromJson(String str) => ActorDetailsModel.fromJson(json.decode(str));

String actorDetailsModelToJson(ActorDetailsModel data) => json.encode(data.toJson());

class ActorDetailsModel {
  List<ActorMovie> movies;
  List<ActorVideo> videos;
  List<ActorSeries> series;
  List<ActorAudio> audio;

  ActorDetailsModel({
    required this.movies,
    required this.series,
    required this.videos,
    required this.audio,
  });

  factory ActorDetailsModel.fromJson(Map<String, dynamic> json) => ActorDetailsModel(
    movies: (json["movies"] != null)
        ? List<ActorMovie>.from(json["movies"].map((x) => ActorMovie.fromJson(x)))
        : [],
    series: (json["tv_series"] != null)
        ? List<ActorSeries>.from(json["tv_series"].map((x) => ActorSeries.fromJson(x)))
        : [],
    videos: (json["videos"] != null)
        ? List<ActorVideo>.from(json["videos"].map((x) => ActorVideo.fromJson(x)))
        : [],
    audio: (json["audio"] != null)
        ? List<ActorAudio>.from(json["audio"].map((x) => ActorAudio.fromJson(x)))
        : [],
  );


  Map<String, dynamic> toJson() => {
    "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
    "tv_series": List<dynamic>.from(series.map((x) => x)),
    "videos": List<dynamic>.from(videos.map((x) => x)),
    "audio": List<dynamic>.from(audio.map((x) => x)),
  };
}

class ActorMovie {
  int id;
  String name;
  String slug;
  String posterImg;
  String thumbnailImg;


  ActorMovie({
    required this.id,

    required this.name,
    required this.slug,
    required this.posterImg,
    required this.thumbnailImg,

  });

  factory ActorMovie.fromJson(Map<String, dynamic> json) => ActorMovie(
    id: json["id"],

    name: json["name"]?? "",
    slug: json["slug"]?? "",
    posterImg: json["poster_img"]?? "",
    thumbnailImg: json["thumbnail_img"]?? "",

  );

  Map<String, dynamic> toJson() => {
    "id": id,

    "name": name,
    "slug": slug,
    "poster_img": posterImg,
    "thumbnail_img": thumbnailImg,

  };
}

class ActorVideo {
  int id;
  String name;
  String slug;
  String thumbnailImg;


  ActorVideo({
    required this.id,

    required this.name,
    required this.slug,
    required this.thumbnailImg,

  });

  factory ActorVideo.fromJson(Map<String, dynamic> json) => ActorVideo(
    id: (json["id"]??0),

    name: json["name"]?.toString() ??"",
    slug: json["slug"]?.toString() ??"",
    thumbnailImg: json["thumbnail_img"]?.toString() ??"",

  );

  Map<String, dynamic> toJson() => {
    "id": id,

    "name": name,
    "slug": slug,
    "thumbnail_img": thumbnailImg,

  };
}

class ActorSeries {
  int id;
  String name;
  String slug;
  String thumbnailImg;

  ActorSeries({
    required this.id,

    required this.name,
    required this.slug,
    required this.thumbnailImg,

  });

  factory ActorSeries.fromJson(Map<String, dynamic> json) => ActorSeries(
    id: (json["id"]??0),

    name: json["name"]?.toString() ??"",
    slug: json["slug"]?.toString() ??"",
    thumbnailImg: json["thumbnail_img"]?.toString() ??"",

  );

  Map<String, dynamic> toJson() => {
    "id": id,

    "name": name,
    "slug": slug,
    "thumbnail_img": thumbnailImg,

  };
}

class ActorAudio {
  int id;
  String name;
  String slug;
  String thumbnailImg;


  ActorAudio({
    required this.id,

    required this.name,
    required this.slug,
    required this.thumbnailImg,

  });

  factory ActorAudio.fromJson(Map<String, dynamic> json) => ActorAudio(
    id: (json["id"]??0),

    name: json["name"]?.toString() ??"",
    slug: json["slug"]?.toString() ??"",
    thumbnailImg: json["thumbnail_img"]?.toString() ??"",

  );

  Map<String, dynamic> toJson() => {
    "id": id,

    "name": name,
    "slug": slug,
    "thumbnail_img": thumbnailImg,

  };
}

