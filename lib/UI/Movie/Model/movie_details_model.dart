

import 'dart:convert';
import 'dart:io';

import 'package:myott/UI/Actors/Model/ActorsModel.dart';
import 'package:myott/UI/Model/BaseCommentsModel.dart';

MovieDetailsModel movieDetailsModelFromJson(String str) => MovieDetailsModel.fromJson(json.decode(str));

String movieDetailsModelToJson(MovieDetailsModel data) => json.encode(data.toJson());

class MovieDetailsModel {
  Movie movie;
  String status;
  List<MovieComments> comment;

  MovieDetailsModel({
    required this.movie,
    required this.status,
    required this.comment,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) => MovieDetailsModel(
    movie: Movie.fromJson(json["movie"]),
    status: json["status"],
    comment: (json["comment"] as List?)?.map((e) => MovieComments.fromJson(e)).toList() ?? [],
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
  String name;
  String slug;
  String posterImg;
  String thumbnailImg;
  int audioLanguage;
  String maturity;
  String trailerUrl;
  String releaseYear;
  String description;
  MoviePackage packages;

  int status;
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
    required this.name,
    required this.slug,
    required this.posterImg,
    required this.thumbnailImg,
    required this.audioLanguage,
    required this.maturity,
    required this.trailerUrl,
    required this.releaseYear,
    required this.description,
    required this.packages,

    required this.status,
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
    name: json["name"],
    slug: json["slug"],
    posterImg: json["poster_img"],
    thumbnailImg: json["thumbnail_img"],
    audioLanguage: json["audio_language"],
    maturity: json["maturity"],
    trailerUrl: json["trailer_url"],
    releaseYear: json["release_year"],
    description: json["description"],
    packages: json["packages"] != null
        ? MoviePackage.fromJson(json["packages"])
        : MoviePackage(id: 0, movieId: 0, free: false, selection: "", coinCost: 0, planPrice: 0, offerPrice: 0),

    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    actors: List<Ctor>.from(json["actors"].map((x) => Ctor.fromJson(x))),
    directors: List<Ctor>.from(json["directors"].map((x) => Ctor.fromJson(x))),
    genres: List<dynamic>.from(json["genres"].map((x) => x)),
    subtitles: _parseMap(json['subtitles']),
    dubbedLanguages: _parseMap(json['dubbed_languages']),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "movie_upload_type": movieUploadType,
    "movie_upload_url": movieUploadUrl,
    "name": name,
    "slug": slug,
    "poster_img": posterImg,
    "thumbnail_img": thumbnailImg,
    "audio_language": audioLanguage,
    "maturity": maturity,
    "trailer_url": trailerUrl,
    "release_year": releaseYear,
    "description": description,

    "status": status,
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



class MoviePackage {
  int id;
  int movieId;
  bool free;
  String selection;
  int coinCost;
  int planPrice;
  int offerPrice;

  MoviePackage({
    required this.id,
    required this.movieId,
    required this.free,
    required this.selection,
    required this.coinCost,
    required this.planPrice,
    required this.offerPrice,
  });

  factory MoviePackage.fromJson(Map<String, dynamic> json) => MoviePackage(
    id: json["id"]??0,
    movieId: json["movie_id"]??0,
    free: json["free"]?? false,
    selection: json["selection"]??"",
    coinCost: json["coin_cost"]??0,
    planPrice: json["plan_price"]??0,
    offerPrice: json["offer_price"]??0,
  );


}

class Ctor {
  final int id;
  final String name;
  final String image;

  Ctor({
   required this.id,
    required this.name,
    required this.image,
  });

  factory Ctor.fromJson(Map<String, dynamic> json) => Ctor(
    id: json["id"] ?? 0, // Default ID to 0 if null
    name: json["name"] ?? "Unknown", // Default name if null
    image: json["image"] ?? "", // Default empty string if null
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}

class MovieComments implements BaseCommentModel {
  int id;
  int userId;
  String name;
  String email;
  int movieId;
  String comment;
  DateTime? createdAt;
  DateTime? updatedAt;

  MovieComments({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.movieId,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MovieComments.fromJson(Map<String, dynamic> json) => MovieComments(
    id: json["id"] ?? 0,
    userId: json["user_id"] ?? 0,
    name: json["name"] ?? "Unknown",
    email: json["email"] ?? "unknown@example.com",
    movieId: json["movie_id"] ?? 0,
    comment: json["comment"] ?? "No comment",
    createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"] ?? "") : null,
    updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"] ?? "") : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "email": email,
    "movie_id": movieId,
    "comment": comment,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
