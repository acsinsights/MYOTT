// To parse this JSON data, do
//
//     final videoDetailsModel = videoDetailsModelFromJson(jsonString);

import 'dart:convert';

class VideoDetailsModel {
  int id;
  String videoUploadType;
  String videoUploadUrl;
  String name;
  String slug;
  String thumbnailImg;
  int audioLanguage;
  String maturity;
  String trailerUrl;
  String releaseYear;
  int views;
  int fakeViews;
  String durationTime;
  String description;
  int status;
  VideoCast cast;
  VideoPackage videoPackage;
  VOrder? vOrder;

  VideoDetailsModel({
    required this.id,
    required this.videoUploadType,
    required this.videoUploadUrl,
    required this.name,
    required this.slug,
    required this.thumbnailImg,
    required this.audioLanguage,
    required this.maturity,
    required this.trailerUrl,
    required this.releaseYear,
    required this.views,
    required this.fakeViews,
    required this.durationTime,
    required this.description,
    required this.videoPackage,
    required this.vOrder,
    required this.status,
    required this.cast,
  });

  factory VideoDetailsModel.fromJson(Map<String, dynamic> json) => VideoDetailsModel(
    id: (json["id"]??0),
    videoUploadType: json["video_upload_type"]?.toString()?? "",
    videoUploadUrl: json["video_upload_url"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
    slug: json["slug"]?.toString() ?? "",
    thumbnailImg: json["thumbnail_img"]?.toString() ?? "",
    audioLanguage: json["audio_language"],
    maturity: json["maturity"]?.toString() ?? "",
    trailerUrl: json["trailer_url"]?.toString() ?? "",
    releaseYear: json["release_year"]??"",
    views: (json["views"]??0),
    fakeViews: (json["fake_views"]??0),
    durationTime: json["duration_time"]?.toString() ?? "",
    description: json["description"]?.toString() ?? "",
    status: json["status"],
    videoPackage: VideoPackage.fromJson(json["video_package"]??{}),
    vOrder: (json["order"] != null && json["order"]["id"] != null)
        ? VOrder.fromJson(json["order"])
        : null,
    cast: VideoCast.fromJson(json["cast"]),
  );

}

class VideoCast {
  List<VideoActor> actors;
  List<VideoActor> directors;
  List<VideoActor> genres;

  VideoCast({
    required this.actors,
    required this.directors,
    required this.genres,
  });

  factory VideoCast.fromJson(Map<String, dynamic> json) => VideoCast(
    actors: json["actors"]!=null?  List<VideoActor>.from(json["actors"].map((x) => VideoActor.fromJson(x))) :[],
    directors: json["directors"]!=null? List<VideoActor>.from(json["directors"].map((x) => VideoActor.fromJson(x))):[],
    genres: json["genres"]!=null ?List<VideoActor>.from(json["genres"].map((x) => VideoActor.fromJson(x))):[],
  );

}

class VideoActor {
  int id;
  String name;
  String image;

  VideoActor({
    required this.id,
    required this.name,
    required this.image,
  });

  factory VideoActor.fromJson(Map<String, dynamic> json) => VideoActor(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    image: json["image"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
class VideoPackage {
  int id;
  int movieId;
  bool free;
  String selection;
  int coinCost;
  int planPrice;
  int offerPrice;

  VideoPackage({
    required this.id,
    required this.movieId,
    required this.free,
    required this.selection,
    required this.coinCost,
    required this.planPrice,
    required this.offerPrice,
  });

  factory VideoPackage.fromJson(Map<String, dynamic> json) => VideoPackage(
    id: json["id"]??0,
    movieId: json["movie_id"]??0,
    free: json["free"]??false,
    selection: json["selection"]??"",
    coinCost: json["coin_cost"]??0,
    planPrice: json["plan_price"]??0,
    offerPrice: json["offer_price"]??0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "movie_id": movieId,
    "free": free,
    "selection": selection,
    "coin_cost": coinCost,
    "plan_price": planPrice,
    "offer_price": offerPrice,
  };
}

class VOrder {
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


  VOrder({
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

  factory VOrder.fromJson(Map<String, dynamic> json) => VOrder(
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