import 'package:myott/UI/Model/Moviesmodel.dart';

class ActorDetialsModel{
  List<ActorsMoviesModel> movies;
  List<ActorsTvSeriesModel> tvSeries;


  ActorDetialsModel({
    required this.movies,
    required this.tvSeries,
  });

  factory ActorDetialsModel.fromJson(Map<String, dynamic> json) => ActorDetialsModel(
    movies: (json['movies'] as List?)?.map((e) => ActorsMoviesModel.fromJson(e)).toList() ?? [],
    tvSeries: (json['tv_series'] as List?)?.map((e) => ActorsTvSeriesModel.fromJson(e)).toList() ?? [],
  );

}


class ActorsMoviesModel {
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
  dynamic scheduleDate;
  dynamic scheduleTime;
  int status;
  Cast cast;

  ActorsMoviesModel({
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

  factory ActorsMoviesModel.fromJson(Map<String, dynamic> json) => ActorsMoviesModel(
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
    scheduleDate: json["schedule_date"],
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
    "schedule_date": scheduleDate,
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


class ActorsTvSeriesModel {
  int id;
  String name;
  String slug;
  String thumbnailImg;
  int audioLanguage;
  String maturity;
  String trailerUrl;
  String description;
  String subAvailable;
  String dubAvailable;
  String seriesUploadType;
  String releaseYear;
  int views;
  int fakeViews;
  dynamic scheduleDate;
  dynamic scheduleTime;
  String status;
  Cast cast;

  ActorsTvSeriesModel({
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
    required this.scheduleDate,
    required this.scheduleTime,
    required this.status,
    required this.cast,
  });

  factory ActorsTvSeriesModel.fromJson(Map<String, dynamic> json) => ActorsTvSeriesModel(
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
    scheduleDate: json["schedule_date"],
    scheduleTime: json["schedule_time"],
    status: json["status"],
    cast: Cast.fromJson(json["cast"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "thumbnail_img": thumbnailImg,
    "audio_language": audioLanguage,
    "maturity": maturity,
    "trailer_url": trailerUrl,
    "description": description,
    "sub_available": subAvailable,
    "dub_available": dubAvailable,
    "series_upload_type": seriesUploadType,
    "release_year": releaseYear,
    "views": views,
    "fake_views": fakeViews,
    "schedule_date": scheduleDate,
    "schedule_time": scheduleTime,
    "status": status,
    "cast": cast.toJson(),
  };
}



