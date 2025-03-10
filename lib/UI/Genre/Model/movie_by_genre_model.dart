// To parse this JSON data, do
//
//     final moviesByGenreModel = moviesByGenreModelFromJson(jsonString);

import 'dart:convert';

List<MoviesByGenreModel> moviesByGenreModelFromJson(String str) => List<MoviesByGenreModel>.from(json.decode(str).map((x) => MoviesByGenreModel.fromJson(x)));

String moviesByGenreModelToJson(List<MoviesByGenreModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MoviesByGenreModel {
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
  String releaseYear;
  String description;
  DateTime? scheduleDate;
  String? scheduleTime;
  int status;
  Cast cast;

  MoviesByGenreModel({
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

  factory MoviesByGenreModel.fromJson(Map<String, dynamic> json) => MoviesByGenreModel(
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
    views: json["views"],
    fakeViews: json["fake_views"],
    releaseYear: json["release_year"],
    description: json["description"],
    scheduleDate: json["schedule_date"] == null ? null : DateTime.parse(json["schedule_date"]),
    scheduleTime: json["schedule_time"],
    status: json["status"],
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
    "release_year": releaseYear,
    "description": description,
    "schedule_date": "${scheduleDate!.year.toString().padLeft(4, '0')}-${scheduleDate!.month.toString().padLeft(2, '0')}-${scheduleDate!.day.toString().padLeft(2, '0')}",
    "schedule_time": scheduleTime,
    "status": status,
    "cast": cast.toJson(),
  };
}

class Cast {
  String actors;
  String directors;
  String genre;
  String regionRestrictions;

  Cast({
    required this.actors,
    required this.directors,
    required this.genre,
    required this.regionRestrictions,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
    actors: json["actors"],
    directors: json["directors"],
    genre: json["genre"],
    regionRestrictions: json["region_restrictions"],
  );

  Map<String, dynamic> toJson() => {
    "actors": actors,
    "directors": directors,
    "genre": genre,
    "region_restrictions": regionRestrictions,
  };
}
