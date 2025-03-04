import 'dart:convert';

TvSeriesDetailsModel tvSeriesDetailsModelFromJson(String str) =>
    TvSeriesDetailsModel.fromJson(json.decode(str));

String tvSeriesDetailsModelToJson(TvSeriesDetailsModel data) =>
    json.encode(data.toJson());

class TvSeriesDetailsModel {
  final Series series;
  final List<Episode> episodes;
  final Meta meta;
  final List<Package> packages;
  final List<Sequal> sequals;

  TvSeriesDetailsModel({
    required this.series,
    required this.episodes,
    required this.meta,
    required this.packages,
    required this.sequals,
  });

  factory TvSeriesDetailsModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailsModel(
        series: Series.fromJson(json["series"]),
        episodes: (json["episodes"] as List? ?? [])
            .map((x) => Episode.fromJson(x))
            .toList(),
        meta: Meta.fromJson(json["meta"]),
        packages: (json["packages"] as List? ?? [])
            .map((x) => Package.fromJson(x))
            .toList(),
        sequals: (json["sequals"] as List? ?? [])
            .map((x) => Sequal.fromJson(x))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    "series": series.toJson(),
    "episodes": episodes.map((x) => x.toJson()).toList(),
    "meta": meta.toJson(),
    "packages": packages.map((x) => x.toJson()).toList(),
    "sequals": sequals.map((x) => x.toJson()).toList(),
  };
}

class Series {
  final int id;
  final String name;
  final String slug;
  final String thumbnail;
  final int audioLanguage;
  final String maturity;
  final String? trailerUrl; // Nullable
  final String description;
  final String subAvailable;
  final String dubAvailable;
  final String uploadType;
  final String releaseYear;
  final int views;
  final int fakeViews;
  final String? scheduleDate; // Nullable
  final String? scheduleTime; // Nullable
  final String status;

  Series({
    required this.id,
    required this.name,
    required this.slug,
    required this.thumbnail,
    required this.audioLanguage,
    required this.maturity,
    this.trailerUrl, // Nullable
    required this.description,
    required this.subAvailable,
    required this.dubAvailable,
    required this.uploadType,
    required this.releaseYear,
    required this.views,
    required this.fakeViews,
    this.scheduleDate, // Nullable
    this.scheduleTime, // Nullable
    required this.status,
  });

  factory Series.fromJson(Map<String, dynamic> json) => Series(
    id: json["id"],
    name: json["name"] ?? '',
    slug: json["slug"] ?? '',
    thumbnail: json["thumbnail"] ?? '',
    audioLanguage: json["audio_language"] ?? 0,
    maturity: json["maturity"] ?? '',
    trailerUrl: json["trailer_url"], // Nullable
    description: json["description"] ?? '',
    subAvailable: json["sub_available"] ?? '',
    dubAvailable: json["dub_available"] ?? '',
    uploadType: json["upload_type"] ?? '',
    releaseYear: json["release_year"] ?? '',
    views: json["views"] ?? 0,
    fakeViews: json["fake_views"] ?? 0,
    scheduleDate: json["schedule_date"], // Nullable
    scheduleTime: json["schedule_time"], // Nullable
    status: json["status"] ?? '',
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

class Episode {
  final int id;
  final int episodeNumber;
  final String title;
  final String description;
  final String poster;
  final String isFree;
  final String uploadUrl;
  final DateTime createdAt;

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
    episodeNumber: json["episode_number"] ?? 0,
    title: json["title"] ?? '',
    description: json["description"] ?? '',
    poster: json["poster"] ?? '',
    isFree: json["is_free"] ?? 'No',
    uploadUrl: json["upload_url"] ?? '',
    createdAt: DateTime.tryParse(json["created_at"] ?? '') ?? DateTime(2000),
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
  final String title;
  final String keywords;
  final String description;
  final String image;

  Meta({
    required this.title,
    required this.keywords,
    required this.description,
    required this.image,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    title: json["title"] ?? '',
    keywords: json["keywords"] ?? '',
    description: json["description"] ?? '',
    image: json["image"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "keywords": keywords,
    "description": description,
    "image": image,
  };
}

class Package {
  final int id;
  final dynamic selection;
  final dynamic coinCost;
  final dynamic planPrice;
  final dynamic offerPrice;
  final String isFree;
  final DateTime? createdAt;

  Package({
    required this.id,
    required this.selection,
    required this.coinCost,
    required this.planPrice,
    required this.offerPrice,
    required this.isFree,
    this.createdAt,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    id: json["id"],
    selection: json["selection"],
    coinCost: json["coin_cost"],
    planPrice: json["plan_price"],
    offerPrice: json["offer_price"],
    isFree: json["is_free"] ?? 'No',
    createdAt: json["created_at"] != null
        ? DateTime.tryParse(json["created_at"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "selection": selection,
    "coin_cost": coinCost,
    "plan_price": planPrice,
    "offer_price": offerPrice,
    "is_free": isFree,
    "created_at": createdAt?.toIso8601String(),
  };
}

class Sequal {
  final int id;
  final String includeSequal;
  final dynamic details;

  Sequal({
    required this.id,
    required this.includeSequal,
    required this.details,
  });

  factory Sequal.fromJson(Map<String, dynamic> json) => Sequal(
    id: json["id"],
    includeSequal: json["include_sequal"] ?? 'No',
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "include_sequal": includeSequal,
    "details": details,
  };
}
