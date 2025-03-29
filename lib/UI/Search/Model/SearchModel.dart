// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

import 'package:myott/UI/Model/searchable_content.dart';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  Results results;

  SearchModel({
    required this.results,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    results: Results.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "results": results.toJson(),
  };
}

class Results {
  Movies movies;
  TvSeries tvSeries;
  Audio audio;

  Results({
    required this.movies,
    required this.tvSeries,
    required this.audio,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    movies: Movies.fromJson(json["movies"]),
    tvSeries: TvSeries.fromJson(json["tv_series"]),
    audio: Audio.fromJson(json["audio"]),
  );

  Map<String, dynamic> toJson() => {
    "movies": movies.toJson(),
    "tv_series": tvSeries.toJson(),
    "audio": audio.toJson(),
  };
}
class TvSeries {
  int currentPage;
  List<MoviesDatum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  TvSeries({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory TvSeries.fromJson(Map<String, dynamic> json) => TvSeries(
    currentPage: json["current_page"],
    data: List<MoviesDatum>.from(json["data"].map((x) => MoviesDatum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}
class TvSeriesDatum extends SearchableContent {
  int id;
  String name;
  String slug;
  String thumbnailImg;
  int audioLanguage;
  String maturity;
  String trailerUrl;
  String description;
  int subAvailable;
  int dubAvailable;
  String seriesUploadType;
  String releaseYear;
  int views;
  int fakeViews;
  dynamic scheduleDate;
  dynamic scheduleTime;
  int status;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  TvSeriesDatum({
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
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  }):super(id: id,name: name,posterImg: thumbnailImg,type: ContentType.tvSeries,slug: slug);

  factory TvSeriesDatum.fromJson(Map<String, dynamic> json) => TvSeriesDatum(
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
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}


class Audio {
  int currentPage;
  List<AudioDatum> data;
  String firstPageUrl;
  int? from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int? to;
  int total;

  Audio({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
    currentPage: json["current_page"],
    data: List<AudioDatum>.from(json["data"].map((x) => AudioDatum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class AudioDatum extends SearchableContent{
  int id;
  String audioUploadType;
  String audioUploadUrl;
  dynamic audioUploadFiles;
  String name;
  String slug;
  String image;
  int audioLanguage;
  String maturity;
  String releaseYear;
  String description;
  dynamic scheduleDate;
  dynamic scheduleTime;
  int status;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  AudioDatum({
    required this.id,
    required this.audioUploadType,
    required this.audioUploadUrl,
    required this.audioUploadFiles,
    required this.name,
    required this.slug,
    required this.image,
    required this.audioLanguage,
    required this.maturity,
    required this.releaseYear,
    required this.description,
    required this.scheduleDate,
    required this.scheduleTime,
    required this.status,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  }): super(id: id,name: name,posterImg: image,type: ContentType.movie,slug: slug);

  factory AudioDatum.fromJson(Map<String, dynamic> json) => AudioDatum(
    id: json["id"],
    audioUploadType: json["audio_upload_type"],
    audioUploadUrl: json["audio_upload_url"],
    audioUploadFiles: json["audio_upload_files"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
    audioLanguage: json["audio_language"],
    maturity: json["maturity"],
    releaseYear: json["release_year"],
    description: json["description"],
    scheduleDate: json["schedule_date"],
    scheduleTime: json["schedule_time"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "audio_upload_type": audioUploadType,
    "audio_upload_url": audioUploadUrl,
    "audio_upload_files": audioUploadFiles,
    "name": name,
    "slug": slug,
    "image": image,
    "audio_language": audioLanguage,
    "maturity": maturity,
    "release_year": releaseYear,
    "description": description,
    "schedule_date": scheduleDate,
    "schedule_time": scheduleTime,
    "status": status,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class Movies {
  int currentPage;
  List<MoviesDatum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Movies({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
    currentPage: json["current_page"],
    data: List<MoviesDatum>.from(json["data"].map((x) => MoviesDatum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class MoviesDatum extends SearchableContent {
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
  int? views;
  int? fakeViews;
  String description;
  dynamic scheduleDate;
  dynamic scheduleTime;
  int status;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  MoviesDatum({
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
    required this.views,
    required this.fakeViews,
    required this.description,
    required this.scheduleDate,
    required this.scheduleTime,
    required this.status,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  }): super(id: id,name: name,posterImg: posterImg,type: ContentType.movie,slug: slug);

  factory MoviesDatum.fromJson(Map<String, dynamic> json) => MoviesDatum(
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
    scheduleDate: json["schedule_date"],
    scheduleTime: json["schedule_time"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "schedule_date": scheduleDate,
    "schedule_time": scheduleTime,
    "status": status,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
