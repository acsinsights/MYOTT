class Video {
  int id;
  String videoUploadType;
  String videoUploadUrl;
  String name;
  String slug;
  String image;
  String thumbnailImg;
  int audioLanguage;
  String maturity;
  DateTime? releaseYear;
  int views;
  int fakeViews;
  int userId;
  String durationTime;
  String description;


  int status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Video({
    required this.id,
    required this.videoUploadType,
    required this.videoUploadUrl,
    required this.name,
    required this.slug,
    required this.image,
    required this.thumbnailImg,
    required this.audioLanguage,
    required this.maturity,
    this.releaseYear,
    required this.views,
    required this.fakeViews,
    required this.userId,
    required this.durationTime,
    required this.description,

    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"] ?? 0,
    videoUploadType: json["video_upload_type"]?.toString() ?? "",
    videoUploadUrl: json["video_upload_url"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
    slug: json["slug"]?.toString() ?? "",
    image: json["image"]?.toString() ?? "",
    thumbnailImg: json["thumbnail_img"]?.toString() ?? "",
    audioLanguage: json["audio_language"] ?? 0,
    maturity: json["maturity"]?.toString() ?? "",
    releaseYear: json["release_year"] != null ? DateTime.tryParse(json["release_year"]) : null,
    views: json["views"] ?? 0,
    fakeViews: json["fake_views"] ?? 0,
    userId: json["user_id"] ?? 0,
    durationTime: json["duration_time"]?.toString() ?? "",
    description: json["description"]?.toString() ?? "",
    status: json["status"] ?? 0,

    createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
    updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) : null,
  );

}

