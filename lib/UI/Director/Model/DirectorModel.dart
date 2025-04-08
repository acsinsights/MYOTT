import 'dart:convert';

DirectorDetailsModel directorDetailsModelFromJson(String str) =>
    DirectorDetailsModel.fromJson(json.decode(str));

String directorDetailsModelToJson(DirectorDetailsModel data) =>
    json.encode(data.toJson());

class DirectorDetailsModel {
  int id;
  String name;
  String image;
  String bio;
  List<DirectorMovie> movies;
  List<DirectorSeries> series;
  List<DirectorVideo> videos;
  List<DirectorAudio> audio;

  DirectorDetailsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.bio,
    required this.movies,
    required this.series,
    required this.videos,
    required this.audio,
  });

  factory DirectorDetailsModel.fromJson(Map<String, dynamic> json) =>
      DirectorDetailsModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        image: json["image"] ?? "",
        bio: json["bio"] ?? "",
        movies: (json["movies"] != null)
            ? List<DirectorMovie>.from(json["movies"].map((x) => DirectorMovie.fromJson(x)))
            : [],
        series: (json["tv_series"] != null)
            ? List<DirectorSeries>.from(json["tv_series"].map((x) => DirectorSeries.fromJson(x)))
            : [],
        videos: (json["videos"] != null)
            ? List<DirectorVideo>.from(json["videos"].map((x) => DirectorVideo.fromJson(x)))
            : [],
        audio: (json["audio"] != null)
            ? List<DirectorAudio>.from(json["audio"].map((x) => DirectorAudio.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "bio": bio,
    "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
    "tv_series": List<dynamic>.from(series.map((x) => x.toJson())),
    "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
    "audio": List<dynamic>.from(audio.map((x) => x.toJson())),
  };
}

class DirectorMovie {
  int id;
  String name;
  String slug;
  String posterImg;
  String thumbnailImg;

  DirectorMovie({
    required this.id,
    required this.name,
    required this.slug,
    required this.posterImg,
    required this.thumbnailImg,
  });

  factory DirectorMovie.fromJson(Map<String, dynamic> json) => DirectorMovie(
    id: json["id"],
    name: json["name"] ?? "",
    slug: json["slug"] ?? "",
    posterImg: json["poster_img"] ?? "",
    thumbnailImg: json["thumbnail_img"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "poster_img": posterImg,
    "thumbnail_img": thumbnailImg,
  };
}

class DirectorVideo {
  int id;
  String name;
  String slug;
  String thumbnailImg;

  DirectorVideo({
    required this.id,
    required this.name,
    required this.slug,
    required this.thumbnailImg,
  });

  factory DirectorVideo.fromJson(Map<String, dynamic> json) => DirectorVideo(
    id: json["id"] ?? 0,
    name: json["name"]?.toString() ?? "",
    slug: json["slug"]?.toString() ?? "",
    thumbnailImg: json["thumbnail_img"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "thumbnail_img": thumbnailImg,
  };
}

class DirectorSeries {
  int id;
  String name;
  String slug;
  String thumbnailImg;

  DirectorSeries({
    required this.id,
    required this.name,
    required this.slug,
    required this.thumbnailImg,
  });

  factory DirectorSeries.fromJson(Map<String, dynamic> json) => DirectorSeries(
    id: json["id"] ?? 0,
    name: json["name"]?.toString() ?? "",
    slug: json["slug"]?.toString() ?? "",
    thumbnailImg: json["thumbnail_img"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "thumbnail_img": thumbnailImg,
  };
}

class DirectorAudio {
  int id;
  String name;
  String slug;
  String thumbnailImg;

  DirectorAudio({
    required this.id,
    required this.name,
    required this.slug,
    required this.thumbnailImg,
  });

  factory DirectorAudio.fromJson(Map<String, dynamic> json) => DirectorAudio(
    id: json["id"] ?? 0,
    name: json["name"]?.toString() ?? "",
    slug: json["slug"]?.toString() ?? "",
    thumbnailImg: json["thumbnail_img"]?.toString() ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "thumbnail_img": thumbnailImg,
  };
}
