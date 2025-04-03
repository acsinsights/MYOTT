// lib/models/searchable_content.dart
abstract class SearchableContent {
  final int id;
  final String name;
  final String posterImg;
  final String slug;
  final ContentType type;

  SearchableContent({
    required this.id,
    required this.name,
    required this.posterImg,
    required this.slug,
    required this.type,
  });
}

enum ContentType { movie, tvSeries, audio }


