
class WatchHistoryResponseModel {
  List<WatchHistory> watchHistory;

  WatchHistoryResponseModel({
    required this.watchHistory,
  });

  factory WatchHistoryResponseModel.fromJson(Map<String, dynamic> json) => WatchHistoryResponseModel(
    watchHistory: List<WatchHistory>.from(json["watch_history"].map((x) => WatchHistory.fromJson(x))),
  );

}

class WatchHistory {
  int id;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  WatchHistoyMovie movie;
  WatchHistoySeries series;
  WatchHistoyAudio audio;
  WatchHistoyVideo video;

  WatchHistory({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.movie,
    required this.series,
    required this.audio,
    required this.video,
  });

  factory WatchHistory.fromJson(Map<String, dynamic> json) => WatchHistory(
    id: json["id"]??0,
    userId: json["user_id"]??0,
    createdAt: json["created_at"] !=null ?DateTime.parse(json["created_at"]):DateTime.now(),
    updatedAt: json["updated_at"] !=null ? DateTime.parse(json["updated_at"]):DateTime.now(),
    movie: WatchHistoyMovie.fromJson(json["movie"]??{}),
    series: WatchHistoySeries.fromJson(json["series"]??{}),
    audio: WatchHistoyAudio.fromJson(json["audio"]??{}),
    video:WatchHistoyVideo.fromJson( json["video"]??{}),
  );

}

class WatchHistoyMovie {
  int id;
  String name;
  String thumbnailImg;
  String slug;

  WatchHistoyMovie({
    required this.id,
    required this.name,
    required this.thumbnailImg,
    required this.slug,
  });

  factory WatchHistoyMovie.fromJson(Map<String, dynamic> json) => WatchHistoyMovie(
    id: json["id"]??0,
    name: json["name"]??"",
    thumbnailImg: json["thumbnail_img"]??"",
    slug: json["slug"]??"",
  );

}
class WatchHistoySeries {
  int id;
  String name;
  String thumbnailImg;
  String slug;

  WatchHistoySeries({
    required this.id,
    required this.name,
    required this.thumbnailImg,
    required this.slug,
  });

  factory WatchHistoySeries.fromJson(Map<String, dynamic> json) => WatchHistoySeries(
    id: json["id"]??0,
    name: json["name"]??"",
    thumbnailImg: json["thumbnail_img"]??"",
    slug: json["slug"]??"",
  );
}
class WatchHistoyAudio {
  int id;
  String name;
  String thumbnailImg;
  String slug;

  WatchHistoyAudio({
    required this.id,
    required this.name,
    required this.thumbnailImg,
    required this.slug,
  });

  factory WatchHistoyAudio.fromJson(Map<String, dynamic> json) => WatchHistoyAudio(
    id: json["id"]??0,
    name: json["name"]??"",
    thumbnailImg: json["thumbnail_img"]??"",
    slug: json["slug"]??"",
  );

}
class WatchHistoyVideo {
  int id;
  String name;
  String thumbnailImg;
  String slug;

  WatchHistoyVideo({
    required this.id,
    required this.name,
    required this.thumbnailImg,
    required this.slug,
  });

  factory WatchHistoyVideo.fromJson(Map<String, dynamic> json) => WatchHistoyVideo(
    id: json["id"]??0,
    name: json["name"]??"",
    thumbnailImg: json["thumbnail_img"]??"",
    slug: json["slug"]??"",
  );

}