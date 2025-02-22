class ComingSoonModel {
  final String title;
  final String imageUrl;
  final int releaseYear;
  final String director;
  final String description;

  ComingSoonModel({
    required this.title,
    required this.imageUrl,
    required this.releaseYear,
    required this.director,
    required this.description,
  });

  factory ComingSoonModel.fromJson(Map<String, dynamic> json) {
    return ComingSoonModel(
      title: json['title'],
      imageUrl: json['imageUrl'],
      releaseYear: json['releaseYear'],
      director: json['director'],
      description: json['description'],
    );
  }
}
