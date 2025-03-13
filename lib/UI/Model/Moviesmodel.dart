import 'dart:convert';

MoviesModel moviesModelFromJson(String str) => MoviesModel.fromJson(json.decode(str));

String moviesModelToJson(MoviesModel data) => json.encode(data.toJson());

class MoviesModel {
  final int id;
  final String movieUploadType;
  final String movieUploadUrl;
  final dynamic movieUploadFiles;
  final String name;
  final String slug;
  final String posterImg;
  final String thumbnailImg;
  final int? audioLanguage; // Nullable to avoid forced 0 if needed
  final String maturity;
  final String trailerUrl;
  final String releaseYear;
  final String description;
  final String? scheduleDate; // Nullable
  final String? scheduleTime; // Nullable
  final int status;
  final String? deletedAt; // Nullable
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String> directors;

  MoviesModel({
    required this.id,
    required this.movieUploadType,
    required this.movieUploadUrl,
    required this.movieUploadFiles,
    required this.name,
    required this.slug,
    required this.posterImg,
    required this.thumbnailImg,
    this.audioLanguage, // Nullable
    required this.maturity,
    required this.trailerUrl,
    required this.releaseYear,
    required this.description,
    this.scheduleDate, // Nullable
    this.scheduleTime, // Nullable
    required this.status,
    this.deletedAt, // Nullable
    this.createdAt,
    this.updatedAt,
    required this.directors,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
    id: json["id"] ?? 0,
    movieUploadType: json["movie_upload_type"] ?? "",
    movieUploadUrl: json["movie_upload_url"] ?? "",
    movieUploadFiles: json["movie_upload_files"] ?? "",
    name: json["name"] ?? "",
    slug: json["slug"] ?? "",
    posterImg: json["poster_img"] ?? "",
    thumbnailImg: json["thumbnail_img"] ?? "",
    audioLanguage: json["audio_language"], // Nullable
    maturity: json["maturity"] ?? "",
    trailerUrl: json["trailer_url"] ?? "",
    releaseYear: json["release_year"] ?? "",
    description: json["description"] ?? "",
    scheduleDate: json["schedule_date"], // Nullable
    scheduleTime: json["schedule_time"], // Nullable
    status: json["status"] ?? 0,
    deletedAt: json["deleted_at"], // Nullable
    createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
    updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) : null,
    directors: (json["directors"] as List?)?.map((x) => x.toString()).toList() ?? [], // Safe handling
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "directors": directors, // No need for `.map()` since it's already a list
  };
}
