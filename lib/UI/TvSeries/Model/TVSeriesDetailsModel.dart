

import 'dart:convert';

import '../../Model/BaseCommentsModel.dart';


class SeriesDetailResponse {
  Series series;
  List<Episode> episodes;
  List<SeriesComments> comments;


  SeriesDetailResponse({
    required this.series,
    required this.episodes,
    required this.comments
  });

  factory SeriesDetailResponse.fromJson(Map<String, dynamic> json) => SeriesDetailResponse(
    series: Series.fromJson(json["series"]),
    episodes: json["episodes"]!=null? List<Episode>.from(json["episodes"].map((x) => Episode.fromJson(x))):[],
    comments: json["comment"] != null ? List<SeriesComments>.from(json["comment"].map((x) => SeriesComments.fromJson(x))) : [],
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


class SeriesPackage {
  int id;
  String selection;
  int coinCost;
  int planPrice;
  int offerPrice;
  bool isFree; // ✅ Changed from String to bool

  SeriesPackage({
    required this.id,
    required this.selection,
    required this.coinCost,
    required this.planPrice,
    required this.offerPrice,
    required this.isFree,
  });

  factory SeriesPackage.fromJson(Map<String, dynamic> json) => SeriesPackage(
    id: json["id"] ?? 0,
    selection: json["selection"] ?? "",
    coinCost: json["coin_cost"] ?? 0,
    planPrice: json["plan_price"] ?? 0,
    offerPrice: json["offer_price"] ?? 0,
    isFree: json["is_free"]?? false, // ✅ Convert "yes"/"no" to bool
  );

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
  String releaseYear;
  int views;
  int fakeViews;
  String status;
  SeriesPackage seriesPackage;
  List<TvSeriesActor> actors;
  List<TvSeriesActor> directors;
  List<TvSeriesActor> genres;
  SOrder seriesorder;

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
    required this.seriesorder,
    required this.seriesPackage,
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
    releaseYear: json["release_year"]??"",
    views: json["views"]??"",
    fakeViews: json["fake_views"]??"",
    status: json["status"]??"",
    seriesorder: SOrder.fromJson(json["order"] ?? {}),
    seriesPackage: SeriesPackage.fromJson(json["series_package"]??{}),
    actors: json["actors"]!=null?List<TvSeriesActor>.from(json["actors"].map((x) => TvSeriesActor.fromJson(x))):[],
    directors: json["directors"]!=null? List<TvSeriesActor>.from(json["directors"].map((x) => TvSeriesActor.fromJson(x))):[],
    genres:json["genres"]!=null? List<TvSeriesActor>.from(json["genres"].map((x) => TvSeriesActor.fromJson(x))):[],
  );

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


class SOrder {
  int id;
  String orderId;
  String invoiceNo;
  int userId;
  int packageId;
  int contentId;
  String contentType;
  String packageType;
  String transactionId;
  String paymentMethod;
  int price;
  int offerPrice;
  String currencyName;
  String transactionStatus;
  String packageStatus;
  DateTime startDate;
  DateTime endDate;


  SOrder({
    required this.id,
    required this.orderId,
    required this.invoiceNo,
    required this.userId,
    required this.packageId,
    required this.contentId,
    required this.contentType,
    required this.packageType,
    required this.transactionId,
    required this.paymentMethod,
    required this.price,
    required this.offerPrice,
    required this.currencyName,
    required this.transactionStatus,
    required this.packageStatus,
    required this.startDate,
    required this.endDate,

  });

  factory SOrder.fromJson(Map<String, dynamic> json) => SOrder(
    id: json["id"]??0,
    orderId: json["order_id"]??"",
    invoiceNo: json["invoice_no"]??"",
    userId: json["user_id"]??0,
    packageId: json["package_id"]??0,
    contentId: json["content_id"]??0,
    contentType: json["content_type"]??"",
    packageType: json["package_type"]??"",
    transactionId: json["transaction_id"]??"",
    paymentMethod: json["payment_method"]??"",
    price: json["price"]??0,
    offerPrice: json["offer_price"]??0,
    currencyName: json["currency_name"]??"",
    transactionStatus: json["transaction_status"]??"",
    packageStatus: json["package_status"]??"",
    startDate: json["start_date"]!=null? DateTime.parse(json["start_date"]): DateTime.now(),
    endDate: json["end_date"] !=null?DateTime.parse(json["end_date"]):DateTime.now(),
  );

}


class SeriesComments implements BaseCommentModel{
  int id;
  String name;
  int userId;
  String email;
  int seriesId;
  String comment;
  DateTime createdAt;
  DateTime updatedAt;

  SeriesComments({
    required this.id,
    required this.name,
    required this.userId,
    required this.email,
    required this.seriesId,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SeriesComments.fromJson(Map<String, dynamic> json) => SeriesComments(
    id: json["id"]??"",
    name: json["name"]??"",
    userId: json["user_id"]??"",
    email: json["email"]??"",
    seriesId: json["tv_series_id"]??"",
    comment: json["comment"]??"",
    createdAt:  json["create_at"]!=null?DateTime.parse(json["created_at"]):DateTime.now(),
    updatedAt:  json["update_at"] !=null ? DateTime.parse(json["updated_at"]):DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "user_id": userId,
    "email": email,
    "blog_id": seriesId,
    "comment": comment,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
