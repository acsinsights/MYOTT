class NotificationModel {
  final String id;
  final String title;
  final String description;
  final int? movieId;
  final int? seriesId;
  final int? videoId;
  final int? audioId;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    this.movieId,
    this.seriesId,
    this.videoId,
    this.audioId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['data']['title'],
      description: json['data']['description'],
      movieId: json['data']['movie_id'] != null ? int.tryParse(json['data']['movie_id'].toString()) : null,
      seriesId: json['data']['series_id'] != null ? int.tryParse(json['data']['series_id'].toString()) : null,
      videoId: json['data']['video_id'] != null ? int.tryParse(json['data']['video_id'].toString()) : null,
      audioId: json['data']['audio_id'] != null ? int.tryParse(json['data']['audio_id'].toString()) : null,
    );
  }
}
