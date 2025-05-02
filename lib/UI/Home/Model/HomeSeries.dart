

import '../../TvSeries/Model/TVSeriesDetailsModel.dart';

class HomeSeries {
  int id;
  String name;
  String slug;
  String thumbnailImg;
  List<Episode> episodes;
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
    episodes: json["episodes"]!=null? List<Episode>.from(json["episodes"].map((x) => Episode.fromJson(x))):[],
    name: json["name"]??"",
    slug: json["slug"]??"",
    seriesPackage: SeriesPackage.fromJson(json["series_package"]??{}),
    seriesorder: (json["order"] != null && json["order"]["id"] != null)
        ? SOrder.fromJson(json["order"])
        : null,
    thumbnailImg: json["thumbnail_img"]??"",

  );

}
