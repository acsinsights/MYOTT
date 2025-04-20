class Video {
  final int id;
  final String name;
  final String slug;
  final String image;
  final String thumbnailImg;

  Video({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.thumbnailImg,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      slug: json["slug"] ?? "",
      image: json["image"] ?? "",
      thumbnailImg: json["thumbnail_img"] ?? "",
    );
  }
}
