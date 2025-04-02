


class GenreDetailsResponseModel {
  List<GenreMovieModel> movies;
  List<GnereTvSeriesModel> tvSeries;
  List<GenreVideoModel> videos;
  List<GenreAudioModel> audios;

  GenreDetailsResponseModel({
    required this.movies,
    required this.tvSeries,
    required this.videos,
    required this.audios
  });

  factory GenreDetailsResponseModel.fromJson(Map<String, dynamic> json) => GenreDetailsResponseModel(
    movies: List<GenreMovieModel>.from(json["movies"].map((x) => GenreMovieModel.fromJson(x))??{}),
    tvSeries: List<GnereTvSeriesModel>.from(json["tv_series"].map((x) => GnereTvSeriesModel.fromJson(x))??{}),
    videos: List<GenreVideoModel>.from(json["videos"].map((x) => GenreVideoModel.fromJson(x))??{}),
    audios: List<GenreAudioModel>.from(json["audios"].map((x) => GenreAudioModel.fromJson(x))??{}),

  );

}

class GenreMovieModel {
  int id;
  String name;
  String slug;
  String posterImg;
  String thumbnailImg;


  GenreMovieModel({
    required this.id,

    required this.name,
    required this.slug,
    required this.posterImg,
    required this.thumbnailImg,
  });

  factory GenreMovieModel.fromJson(Map<String, dynamic> json) => GenreMovieModel(
    id: json["id"],

    name: json["name"],
    slug: json["slug"],
    posterImg: json["poster_img"],
    thumbnailImg: json["thumbnail_img"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,

    "name": name,
    "slug": slug,
    "poster_img": posterImg,
    "thumbnail_img": thumbnailImg,
  };
}

class GnereTvSeriesModel {
  int id;
  String name;
  String slug;
  String thumbnailImg;


  GnereTvSeriesModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.thumbnailImg,
  });

  factory GnereTvSeriesModel.fromJson(Map<String, dynamic> json) => GnereTvSeriesModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    thumbnailImg: json["thumbnail_img"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "thumbnail_img": thumbnailImg,

  };
}

class GenreVideoModel {
  int id;

  String name;
  String slug;
  String thumbnailImg;


  GenreVideoModel({
    required this.id,

    required this.name,
    required this.slug,
    required this.thumbnailImg,

  });

  factory GenreVideoModel.fromJson(Map<String, dynamic> json) => GenreVideoModel(
    id: json["id"],

    name: json["name"],
    slug: json["slug"],
    thumbnailImg: json["thumbnail_img"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,

    "name": name,
    "slug": slug,
    "thumbnail_img": thumbnailImg,
  };
}

class GenreAudioModel {
  int id;
  String name;
  String slug;
  String thumbnailImg;

  GenreAudioModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.thumbnailImg,

  });

  factory GenreAudioModel.fromJson(Map<String, dynamic> json) => GenreAudioModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    thumbnailImg: json["thumbnail_img"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "thumbnail_img": thumbnailImg,
  };
}

