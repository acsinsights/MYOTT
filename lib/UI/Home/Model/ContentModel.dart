class   ContentModel {
  final int id;
  final String type;
  final String name;
  final String slug;
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
    required this.slug,
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
      slug: json['slug'] ?? '',
      description: json['description'],
      posterImg: json['poster_img'] ?? '',
      thumbnailImg: json['thumbnail_img'],
      trailerUrl: json['trailer_url'],
      movieUploadUrl: json['movie_upload_url'],
      releaseYear: json['release_year'],
    );
  }
}
