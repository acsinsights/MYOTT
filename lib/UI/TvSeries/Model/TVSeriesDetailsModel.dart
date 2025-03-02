// To parse this JSON data, do
//
//     final tvSeriesDetailsModel = tvSeriesDetailsModelFromJson(jsonString);

import 'dart:convert';

TvSeriesDetailsModel tvSeriesDetailsModelFromJson(String str) => TvSeriesDetailsModel.fromJson(json.decode(str));

String tvSeriesDetailsModelToJson(TvSeriesDetailsModel data) => json.encode(data.toJson());

class TvSeriesDetailsModel {
  Series series;
  List<Episode> episodes;
  Meta meta;
  List<Package> packages;
  List<Sequal> sequals;

  TvSeriesDetailsModel({
    required this.series,
    required this.episodes,
    required this.meta,
    required this.packages,
    required this.sequals,
  });

  factory TvSeriesDetailsModel.fromJson(Map<String, dynamic> json) => TvSeriesDetailsModel(
    series: Series.fromJson(json["series"]),
    episodes: List<Episode>.from(json["episodes"].map((x) => Episode.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
    packages: List<Package>.from(json["packages"].map((x) => Package.fromJson(x))),
    sequals: List<Sequal>.from(json["sequals"].map((x) => Sequal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "series": series.toJson(),
    "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
    "meta": meta.toJson(),
    "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
    "sequals": List<dynamic>.from(sequals.map((x) => x.toJson())),
  };
}

class Episode {
  int id;
  int episodeNumber;
  String title;
  String description;
  String poster;
  String isFree;
  String uploadUrl;
  DateTime createdAt;

  Episode({
    required this.id,
    required this.episodeNumber,
    required this.title,
    required this.description,
    required this.poster,
    required this.isFree,
    required this.uploadUrl,
    required this.createdAt,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
    id: json["id"],
    episodeNumber: json["episode_number"],
    title: json["title"],
    description: json["description"],
    poster: json["poster"],
    isFree: json["is_free"],
    uploadUrl: json["upload_url"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "episode_number": episodeNumber,
    "title": title,
    "description": description,
    "poster": poster,
    "is_free": isFree,
    "upload_url": uploadUrl,
    "created_at": createdAt.toIso8601String(),
  };
}

class Meta {
  String title;
  String keywords;
  String description;
  String image;

  Meta({
    required this.title,
    required this.keywords,
    required this.description,
    required this.image,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    title: json["title"],
    keywords: json["keywords"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "keywords": keywords,
    "description": description,
    "image": image,
  };
}

class Package {
  int id;
  String selection;
  dynamic coinCost;
  dynamic planPrice;
  dynamic offerPrice;
  String isFree;
  DateTime createdAt;

  Package({
    required this.id,
    required this.selection,
    required this.coinCost,
    required this.planPrice,
    required this.offerPrice,
    required this.isFree,
    required this.createdAt,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    id: json["id"],
    selection: json["selection"],
    coinCost: json["coin_cost"],
    planPrice: json["plan_price"],
    offerPrice: json["offer_price"],
    isFree: json["is_free"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "selection": selection,
    "coin_cost": coinCost,
    "plan_price": planPrice,
    "offer_price": offerPrice,
    "is_free": isFree,
    "created_at": createdAt.toIso8601String(),
  };
}

class Sequal {
  int id;
  String includeSequal;
  dynamic details;

  Sequal({
    required this.id,
    required this.includeSequal,
    required this.details,
  });

  factory Sequal.fromJson(Map<String, dynamic> json) => Sequal(
    id: json["id"],
    includeSequal: json["include_sequal"],
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "include_sequal": includeSequal,
    "details": details,
  };
}

class Series {
  int id;
  String name;
  String slug;
  String thumbnail;
  int audioLanguage;
  String maturity;
  String trailerUrl;
  String description;
  String subAvailable;
  String dubAvailable;
  String uploadType;
  String releaseYear;
  int views;
  int fakeViews;
  dynamic scheduleDate;
  dynamic scheduleTime;
  String status;

  Series({
    required this.id,
    required this.name,
    required this.slug,
    required this.thumbnail,
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
    required this.scheduleDate,
    required this.scheduleTime,
    required this.status,
  });

  factory Series.fromJson(Map<String, dynamic> json) => Series(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    thumbnail: json["thumbnail"],
    audioLanguage: json["audio_language"],
    maturity: json["maturity"],
    trailerUrl: json["trailer_url"],
    description: json["description"],
    subAvailable: json["sub_available"],
    dubAvailable: json["dub_available"],
    uploadType: json["upload_type"],
    releaseYear: json["release_year"],
    views: json["views"],
    fakeViews: json["fake_views"],
    scheduleDate: json["schedule_date"],
    scheduleTime: json["schedule_time"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "thumbnail": thumbnail,
    "audio_language": audioLanguage,
    "maturity": maturity,
    "trailer_url": trailerUrl,
    "description": description,
    "sub_available": subAvailable,
    "dub_available": dubAvailable,
    "upload_type": uploadType,
    "release_year": releaseYear,
    "views": views,
    "fake_views": fakeViews,
    "schedule_date": scheduleDate,
    "schedule_time": scheduleTime,
    "status": status,
  };
}
