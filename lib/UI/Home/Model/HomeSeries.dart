

import '../../TvSeries/Model/TVSeriesDetailsModel.dart';

class HomeSeries {
  int id;
  String name;
  String slug;
  String thumbnailImg;
  List<HomeseriesEpisode> episodes;
  SeriesPackage seriesPackage;
  SOrder? seriesorder;



  HomeSeries({
    required this.id,
    required this.name,
    required this.slug,
    required this.thumbnailImg,
    required this.episodes,
    required this.seriesPackage,
    required this.seriesorder,

  });

  factory HomeSeries.fromJson(Map<String, dynamic> json) => HomeSeries(
    id: json["id"]??0,
    episodes: json["episodes"]!=null? List<HomeseriesEpisode>.from(json["episodes"].map((x) => HomeseriesEpisode.fromJson(x))):[],
    name: json["name"]??"",
    slug: json["slug"]??"",
    seriesPackage: SeriesPackage.fromJson(json["series_package"]??{}),
    seriesorder: (json["order"] != null && json["order"]["id"] != null)
        ? SOrder.fromJson(json["order"])
        : null,
    thumbnailImg: json["thumbnail_img"]??"",

  );

}
class HomeseriesEpisode {
  int? id;
  int? episodeNumber;
  String? title;
  String? description;
  String? posterImage;
  String? uploadUrl;
  bool? episodeFree;
  DateTime? createdAt;
  DateTime? updatedAt;

  HomeseriesEpisode({
    this.id,
    this.episodeNumber,
    this.title,
    this.description,
    this.posterImage,
    this.uploadUrl,
    this.episodeFree,
    this.createdAt,
    this.updatedAt,
  });


  factory HomeseriesEpisode.fromJson(Map<String, dynamic> json) => HomeseriesEpisode(
    id: json["id"],
    episodeNumber: json["episode_number"],
    title: json["title"],
    description: json["description"],
    posterImage: json["poster_image"],
    uploadUrl: json["upload_url"],
    episodeFree: json["episode_free"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

}
