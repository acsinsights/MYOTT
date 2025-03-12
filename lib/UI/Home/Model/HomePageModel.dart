import '../../Model/Moviesmodel.dart';
import 'SliderModel.dart';

class HomePageModel {
  final List<MoviesModel> latest;
  final List<MoviesModel> top10;
  final List<MoviesModel> newArrival;
  final List<MoviesModel> upcomingMovies; // No need for nullable now
  final List<SliderItemModel> slider;


  HomePageModel({
    required this.latest,
    required this.top10,
    required this.newArrival,
    required this.upcomingMovies, // Ensuring it's always initialized
    required this.slider,
  });

  factory HomePageModel.fromJson(Map<String, dynamic> json) {
    return HomePageModel(
      latest: (json['latest'] as List?)?.map((e) => MoviesModel.fromJson(e)).toList() ?? [],
      top10: (json['top_movies'] as List?)?.map((e) => MoviesModel.fromJson(e)).toList() ?? [],
      newArrival: (json['new_arrivals'] as List?)?.map((e) => MoviesModel.fromJson(e)).toList() ?? [],
      upcomingMovies: (json['upcoming_movies'] as List?)?.map((e) => MoviesModel.fromJson(e)).toList() ?? [],
      slider: json['slider'] != null
          ? (json['slider'] as List).map((e) => SliderItemModel.fromJson(e)).toList()
          : [],
    );
  }
}
