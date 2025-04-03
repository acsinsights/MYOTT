

import 'dart:convert';


class SeriesDetailResponse {
  Series series;
  List<Episode> episodes;
  List<Package> packages;

  SeriesDetailResponse({
    required this.series,
    required this.episodes,
    required this.packages,
  });

  factory SeriesDetailResponse.fromJson(Map<String, dynamic> json) => SeriesDetailResponse(
    series: Series.fromJson(json["series"]),
    episodes: json["episodes"]!=null? List<Episode>.from(json["episodes"].map((x) => Episode.fromJson(x))):[],
    packages: json["packages"]!=null ? List<Package>.from(json["packages"].map((x) => Package.fromJson(x))):[],
  );

}

class Episode {
  int id;
  int episodeNumber;
  String title;
  String description;
  String poster;
  bool isFree; // ✅ Changed from String to bool
  String uploadUrl;

  Episode({
    required this.id,
    required this.episodeNumber,
    required this.title,
    required this.description,
    required this.poster,
    required this.isFree,
    required this.uploadUrl,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
    id: json["id"] ?? 0,
    episodeNumber: json["episode_number"] ?? 0,
    title: json["title"] ?? "",
    description: json["description"] ?? "",
    poster: json["poster"] ?? "",
    isFree: json["is_free"]?.toLowerCase() == "yes", // ✅ Convert "yes"/"no" to bool
    uploadUrl: json["upload_url"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "episode_number": episodeNumber,
    "title": title,
    "description": description,
    "poster": poster,
    "is_free": isFree ? "yes" : "no", // ✅ Convert bool back to string
    "upload_url": uploadUrl,
  };
}


class Package {
  int id;
  String selection;
  int coinCost;
  int planPrice;
  int offerPrice;
  bool isFree; // ✅ Changed from String to bool

  Package({
    required this.id,
    required this.selection,
    required this.coinCost,
    required this.planPrice,
    required this.offerPrice,
    required this.isFree,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    id: json["id"] ?? 0,
    selection: json["selection"] ?? "",
    coinCost: json["coin_cost"] ?? 0,
    planPrice: json["plan_price"] ?? 0,
    offerPrice: json["offer_price"] ?? 0,
    isFree: json["is_free"]?.toLowerCase() == "yes", // ✅ Convert "yes"/"no" to bool
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "selection": selection,
    "coin_cost": coinCost,
    "plan_price": planPrice,
    "offer_price": offerPrice,
    "is_free": isFree ? "yes" : "no", // ✅ Convert bool back to string
  };
}


class Series {
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
  String uploadType;
  DateTime releaseYear;
  int views;
  int fakeViews;
  String status;
  List<TvSeriesActor> actors;
  List<TvSeriesActor> directors;
  List<TvSeriesActor> genres;

  Series({
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
    required this.uploadType,
    required this.releaseYear,
    required this.views,
    required this.fakeViews,

    required this.status,
    required this.actors,
    required this.directors,
    required this.genres,
  });

  factory Series.fromJson(Map<String, dynamic> json) => Series(
    id: json["id"]??0,
    name: json["name"]??"",
    slug: json["slug"]??"",
    thumbnailImg: json["thumbnail_img"]??"",
    audioLanguage: json["audio_language"]??"",
    maturity: json["maturity"]??"",
    trailerUrl: json["trailer_url"]??"",
    description: json["description"]??"",
    subAvailable: json["sub_available"]??"",
    dubAvailable: json["dub_available"]??"",
    uploadType: json["upload_type"]??"",
    releaseYear: json["release_year"]!=null?DateTime.parse(json["release_year"]):DateTime.now(),
    views: json["views"]??"",
    fakeViews: json["fake_views"]??"",
    status: json["status"]??"",
    actors: json["actors"]!=null?List<TvSeriesActor>.from(json["actors"].map((x) => TvSeriesActor.fromJson(x))):[],
    directors: json["directors"]!=null? List<TvSeriesActor>.from(json["directors"].map((x) => TvSeriesActor.fromJson(x))):[],
    genres:json["genres"]!=null? List<TvSeriesActor>.from(json["genres"].map((x) => TvSeriesActor.fromJson(x))):[],
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
    "upload_type": uploadType,
    "release_year": "${releaseYear.year.toString().padLeft(4, '0')}-${releaseYear.month.toString().padLeft(2, '0')}-${releaseYear.day.toString().padLeft(2, '0')}",
    "views": views,
    "fake_views": fakeViews,
    "status": status,
    "actors": List<dynamic>.from(actors.map((x) => x.toJson())),
    "directors": List<dynamic>.from(directors.map((x) => x.toJson())),
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
  };
}

class TvSeriesActor {
  int id;
  String name;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  TvSeriesActor({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TvSeriesActor.fromJson(Map<String, dynamic> json) => TvSeriesActor(
    id: json["id"]??0,
    name: json["name"]??"",
    image: json["image"]??"",
    createdAt: json["created_at"]!=null?DateTime.parse(json["created_at"]):DateTime.now(),
    updatedAt: json["updated_at"]!=null?DateTime.parse(json["updated_at"]):DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
