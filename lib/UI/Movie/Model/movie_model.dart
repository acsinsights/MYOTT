class MovieModel {
  final int id;
  final String title;
  final String imageUrl;
  final String description;
  final int duration;

  MovieModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.duration,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'], // Adjust based on API response
      description: json['description'],
      duration: json['duration'] ?? 0,
    );
  }
}
