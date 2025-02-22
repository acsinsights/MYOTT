class MovieModel {
  final int id;
  final String title;
  final String imageUrl;
  final String bannerUrl;
  final String description;
  final int duration;
  final double imdbRating;
  final DateTime? releaseDate;
  final String resolution;
  final List<String> genres;
  final List<String> languages;
  final List<String> tags;
  final List<Season> seasons;
  final bool isTrending;
  final bool isFeatured;

  MovieModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.bannerUrl,
    required this.description,
    required this.duration,
    required this.imdbRating,
    required this.releaseDate,
    required this.resolution,
    required this.genres,
    required this.languages,
    required this.tags,
    required this.seasons,
    required this.isTrending,
    required this.isFeatured,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      bannerUrl: json['bannerUrl'] ?? "",
      description: json['description'],
      duration: json['duration'] ?? 0,
      imdbRating: (json['imdbRating'] ?? 0).toDouble(),
      releaseDate: json['releaseDate'] != null ? DateTime.tryParse(json['releaseDate']) : null,
      resolution: json['resolution'] ?? "HD",
      genres: List<String>.from(json['genres'] ?? []),
      languages: List<String>.from(json['languages'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((season) => Season.fromJson(season))
          .toList() ??
          [],
      isTrending: json['isTrending'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
    );
  }
}

class Season {
  final int seasonNumber;
  final List<Episode> episodes;

  Season({required this.seasonNumber, required this.episodes});

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      seasonNumber: json['seasonNumber'],
      episodes: (json['episodes'] as List<dynamic>?)
          ?.map((episode) => Episode.fromJson(episode))
          .toList() ??
          [],
    );
  }
}

class Episode {
  final int episodeNumber;
  final String title;
  final String duration;
  final String imageUrl;

  Episode( {required this.episodeNumber, required this.title, required this.duration,required this.imageUrl});

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      episodeNumber: json['episodeNumber'],
      title: json['title'],
      duration: json['duration'],
      imageUrl: json['imageUrl']
    );
  }
}
