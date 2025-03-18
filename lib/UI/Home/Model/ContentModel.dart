class   ContentModel {
  final int id;
  final String type;
  final String name;
  final String? description;
  final String? posterImg;
  final String? thumbnailImg;
  final String? trailerUrl;
  final String? movieUploadUrl;
  final String? releaseYear;

  ContentModel({
    required this.id,
    required this.type,
    required this.name,
     this.description,
     this.posterImg,
     this.thumbnailImg,
    this.trailerUrl,
    this.movieUploadUrl,
    this.releaseYear,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      id: json['id'],
      type: json['type'] ?? 'unknown', // Default to 'unknown'
      name: json['name'] ?? 'Unknown',
      description: json['description'],
      posterImg: json['poster_img'] ?? '',
      thumbnailImg: json['thumbnail_img'] ?? '',
      trailerUrl: json['trailer_url'],
      movieUploadUrl: json['movie_upload_url'],
      releaseYear: json['release_year'],
    );
  }
}
