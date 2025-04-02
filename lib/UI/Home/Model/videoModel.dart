class Video {
  int id;
  String videoUploadType;
  String videoUploadUrl;
  dynamic videoUploadFiles;
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
  dynamic scheduleDate;
  dynamic scheduleTime;
  int status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Video({
    required this.id,
    required this.videoUploadType,
    required this.videoUploadUrl,
    required this.videoUploadFiles,
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
    this.scheduleDate,
    this.scheduleTime,
    required this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"] ?? 0,
    videoUploadType: json["video_upload_type"]?.toString() ?? "",
    videoUploadUrl: json["video_upload_url"]?.toString() ?? "",
    videoUploadFiles: json["video_upload_files"],
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
    scheduleDate: json["schedule_date"],
    scheduleTime: json["schedule_time"],
    status: json["status"] ?? 0,
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
    updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "video_upload_type": videoUploadType,
    "video_upload_url": videoUploadUrl,
    "video_upload_files": videoUploadFiles,
    "name": name,
    "slug": slug,
    "image": image,
    "thumbnail_img": thumbnailImg,
    "audio_language": audioLanguage,
    "maturity": maturity,
    "release_year": releaseYear != null
        ? "${releaseYear!.year.toString().padLeft(4, '0')}-${releaseYear!.month.toString().padLeft(2, '0')}-${releaseYear!.day.toString().padLeft(2, '0')}"
        : null,
    "views": views,
    "fake_views": fakeViews,
    "user_id": userId,
    "duration_time": durationTime,
    "description": description,
    "schedule_date": scheduleDate,
    "schedule_time": scheduleTime,
    "status": status,
    "deleted_at": deletedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
