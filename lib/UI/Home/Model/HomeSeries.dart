

import '../../TvSeries/Model/TVSeriesDetailsModel.dart';

class HomeSeries {
  int id;
  String name;
  String slug;
  String thumbnailImg;
  List<Episode> episodes;


  HomeSeries({
    required this.id,
    required this.name,
    required this.slug,
    required this.thumbnailImg,
    required this.episodes,

  });

  factory HomeSeries.fromJson(Map<String, dynamic> json) => HomeSeries(
    id: json["id"]??0,
    episodes: json["episodes"]!=null? List<Episode>.from(json["episodes"].map((x) => Episode.fromJson(x))):[],
    name: json["name"]??"",
    slug: json["slug"]??"",
    thumbnailImg: json["thumbnail_img"]??"",

  );

}
