class Video {
  int id;
  String videoUploadType;
  String videoUploadUrl;
  String name;
  String slug;
  String image;
  String thumbnailImg;

  Video({
    required this.id,
    required this.videoUploadType,
    required this.videoUploadUrl,
    required this.name,
    required this.slug,
    required this.image,
    required this.thumbnailImg,

  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"] ?? 0,
    videoUploadType: json["video_upload_type"]?.toString() ?? "",
    videoUploadUrl: json["video_upload_url"]?.toString() ?? "",
    name: json["name"]?.toString() ?? "",
    slug: json["slug"]?.toString() ?? "",
    image: json["image"]?.toString() ?? "",
    thumbnailImg: json["thumbnail_img"]?.toString() ?? "",

  );

}

