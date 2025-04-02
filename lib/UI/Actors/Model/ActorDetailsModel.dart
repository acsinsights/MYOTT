// To parse this JSON data, do
//
//     final actorDetailsModel = actorDetailsModelFromJson(jsonString);

import 'dart:convert';

ActorDetailsModel actorDetailsModelFromJson(String str) => ActorDetailsModel.fromJson(json.decode(str));

String actorDetailsModelToJson(ActorDetailsModel data) => json.encode(data.toJson());

class ActorDetailsModel {
  List<Movie> movies;
  List<Video> videos;
  // List<Movie> videos;
  // List<Movie> audio;

  ActorDetailsModel({
    required this.movies,
    // required this.tvSeries,
    required this.videos,
    // required this.audio,
  });

  factory ActorDetailsModel.fromJson(Map<String, dynamic> json) => ActorDetailsModel(
    movies: (json["movies"] != null)
        ? List<Movie>.from(json["movies"].map((x) => Movie.fromJson(x)))
        : [],
    // tvSeries: (json["tv_series"] != null)
    //     ? List<Movie>.from(json["tv_series"].map((x) => Movie.fromJson(x)))
    //     : [],
    videos: (json["videos"] != null)
        ? List<Video>.from(json["videos"].map((x) => Video.fromJson(x)))
        : [],
    // audio: (json["audio"] != null)
    //     ? List<Movie>.from(json["audio"].map((x) => Movie.fromJson(x)))
    //     : [],
  );


  Map<String, dynamic> toJson() => {
    "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
    // "tv_series": List<dynamic>.from(tvSeries.map((x) => x)),
    // "videos": List<dynamic>.from(videos.map((x) => x)),
    // "audio": List<dynamic>.from(audio.map((x) => x)),
  };
}

class Movie {
  int id;
  String movieUploadType;
  String movieUploadUrl;
  dynamic movieUploadFiles;
  String name;
  String slug;
  String posterImg;
  String thumbnailImg;
  int audioLanguage;
  String maturity;
  String trailerUrl;
  int views;
  int fakeViews;
  DateTime releaseYear;
  String description;
  dynamic scheduleDate;
  dynamic scheduleTime;
  int status;
  Cast cast;

  Movie({
    required this.id,
    required this.movieUploadType,
    required this.movieUploadUrl,
    required this.movieUploadFiles,
    required this.name,
    required this.slug,
    required this.posterImg,
    required this.thumbnailImg,
    required this.audioLanguage,
    required this.maturity,
    required this.trailerUrl,
    required this.views,
    required this.fakeViews,
    required this.releaseYear,
    required this.description,
    required this.scheduleDate,
    required this.scheduleTime,
    required this.status,
    required this.cast,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json["id"],
    movieUploadType: json["movie_upload_type"] ?? "",
    movieUploadUrl: json["movie_upload_url"]?? "",
    movieUploadFiles: json["movie_upload_files"]?? "",
    name: json["name"]?? "",
    slug: json["slug"]?? "",
    posterImg: json["poster_img"]?? "",
    thumbnailImg: json["thumbnail_img"]?? "",
    audioLanguage: json["audio_language"]?? "",
    maturity: json["maturity"]?? "",
    trailerUrl: json["trailer_url"]?? "",
    views: json["views"]?? "",
    fakeViews: json["fake_views"]?? "",
    releaseYear: DateTime.parse(json["release_year"]),
    description: json["description"]?? "",
    scheduleDate: json["schedule_date"]?? "",
    scheduleTime: json["schedule_time"]?? "",
    status: json["status"]?? "",
    cast: Cast.fromJson(json["cast"]),
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
    "views": views,
    "fake_views": fakeViews,
    "release_year": "${releaseYear.year.toString().padLeft(4, '0')}-${releaseYear.month.toString().padLeft(2, '0')}-${releaseYear.day.toString().padLeft(2, '0')}",
    "description": description,
    "schedule_date": scheduleDate,
    "schedule_time": scheduleTime,
    "status": status,
    "cast": cast.toJson(),
  };
}
class Video {
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

  Video({
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

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: (json["id"]??0),
    videoUploadType: json["video_upload_type"]?.toString() ??"",
    videoUploadUrl: json["video_upload_url"]?.toString() ??"",
    videoUploadFiles: json["video_upload_files"]?.toString() ??"",
    name: json["name"]?.toString() ??"",
    slug: json["slug"]?.toString() ??"",
    thumbnailImg: json["thumbnail_img"]?.toString() ??"",
    audioLanguage: json["audio_language"],
    maturity: json["maturity"]?.toString() ??"",
    trailerUrl: json["trailer_url"]?.toString() ??"",
    releaseYear: DateTime.parse(json["release_year"]),
    views: json["views"],
    fakeViews: json["fake_views"],
    durationTime: json["duration_time"]?.toString() ??"",
    description: json["description"]?.toString() ??"",
    scheduleDate: json["schedule_date"]?.toString() ??"",
    scheduleTime: json["schedule_time"]?.toString() ??"",
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
    actors: List<Actor>.from(json["actors"].map((x) => Actor.fromJson(x))),
    directors: List<Actor>.from(json["directors"].map((x) => Actor.fromJson(x))),
    genres: List<Actor>.from(json["genres"].map((x) => Actor.fromJson(x))),
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
    name: json["name"]?? "",
    slug: json["slug"]?? "",
    image: json["image"]?? "",
    type: json["type"]?? "",
    description: json["description"]?? "",
    status: json["status"]?? "",
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
