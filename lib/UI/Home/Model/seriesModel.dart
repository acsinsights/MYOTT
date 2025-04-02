

class HomeSeries {
  int id;
  String name;
  String slug;
  String thumbnailImg;

  HomeSeries({
    required this.id,

    required this.name,
    required this.slug,
    required this.thumbnailImg,

  });

  factory HomeSeries.fromJson(Map<String, dynamic> json) => HomeSeries(
    id: json["id"]??0,

    name: json["name"]??"",
    slug: json["slug"]??"",
    thumbnailImg: json["thumbnail_img"]??"",

  );

  Map<String, dynamic> toJson() => {
    "id": id,

    "name": name,
    "slug": slug,
    "thumbnail_img": thumbnailImg,
  };
}
