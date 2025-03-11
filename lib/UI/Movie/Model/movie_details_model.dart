// To parse this JSON data, do
//
//     final movieDetailsModel = movieDetailsModelFromJson(jsonString);

import 'dart:convert';

MovieDetailsModel movieDetailsModelFromJson(String str) => MovieDetailsModel.fromJson(json.decode(str));

String movieDetailsModelToJson(MovieDetailsModel data) => json.encode(data.toJson());

class MovieDetailsModel {
  Movie movie;
  String status;

  MovieDetailsModel({
    required this.movie,
    required this.status,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) => MovieDetailsModel(
    movie: Movie.fromJson(json["movie"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "movie": movie.toJson(),
    "status": status,
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
  String releaseYear;
  String description;
  dynamic scheduleDate;
  dynamic scheduleTime;
  int status;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<Ctor> actors;
  List<Ctor> directors;
  List<dynamic> genres;
  final Map<String, String> subtitles;
  final Map<String, String> dubbedLanguages;

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
    required this.releaseYear,
    required this.description,
    required this.scheduleDate,
    required this.scheduleTime,
    required this.status,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.actors,
    required this.directors,
    required this.genres,
    required this.subtitles,
    required this.dubbedLanguages,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
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
    description: json["description"],
    scheduleDate: json["schedule_date"],
    scheduleTime: json["schedule_time"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    actors: List<Ctor>.from(json["actors"].map((x) => Ctor.fromJson(x))),
    directors:
    List<Ctor>.from(json["directors"].map((x) => Ctor.fromJson(x))),
    genres: List<dynamic>.from(json["genres"].map((x) => x)),
    subtitles: _parseMap(json['subtitles']),
    dubbedLanguages: _parseMap(json['dubbed_languages']),
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
    "description": description,
    "schedule_date": scheduleDate,
    "schedule_time": scheduleTime,
    "status": status,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "actors": List<dynamic>.from(actors.map((x) => x.toJson())),
    "directors": List<dynamic>.from(directors.map((x) => x.toJson())),
    "genres": List<dynamic>.from(genres.map((x) => x)),
    "subtitles": subtitles,
    "dubbed_languages": dubbedLanguages,
  };

  static Map<String, String> _parseMap(dynamic data) {
    if (data == null) {
      return {}; // If null, return empty map
    } else if (data is Map<String, dynamic>) {
      return data.map((key, value) => MapEntry(key, value.toString()));
    } else {
      return {}; // If API returns [], convert to empty map
    }
  }
}

class Ctor {
  int id;
  String name;
  String image;

  Ctor({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Ctor.fromJson(Map<String, dynamic> json) => Ctor(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}

class Subtitles {
  String hi;

  Subtitles({
    required this.hi,
  });

  factory Subtitles.fromJson(Map<String, dynamic> json) => Subtitles(
    hi: json["hi"],
  );

  Map<String, dynamic> toJson() => {
    "hi": hi,
  };
}
