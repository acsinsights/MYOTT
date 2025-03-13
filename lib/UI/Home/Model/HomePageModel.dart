import 'package:myott/UI/Genre/Model/genre_model.dart';
import 'package:myott/UI/Actors/Model/ActorsModel.dart';
import 'package:myott/UI/Home/Model/Audio_Model.dart';
import '../../Model/Moviesmodel.dart';
import 'SliderItemModel.dart';

class HomePageModel {
  final List<MoviesModel> latest;
  final List<MoviesModel> top10;
  final List<MoviesModel> newArrival;
  final List<MoviesModel> upcomingMovies;
  final List<SliderItemModel> slider;
  final List<ActorsModel> actors;
  final List<AudioModel> audios;
  final List<GenreModel> genre;

  HomePageModel({
    required this.latest,
    required this.top10,
    required this.newArrival,
    required this.upcomingMovies,
    required this.slider,
    required this.actors,
    required this.audios,
    required this.genre,
  });

  factory HomePageModel.fromJson(Map<String, dynamic> json) {
    return HomePageModel(
      latest: (json['latest'] as List?)?.map((e) => MoviesModel.fromJson(e)).toList() ?? [],
      top10: (json['top_movies'] as List?)?.map((e) => MoviesModel.fromJson(e)).toList() ?? [],
      newArrival: (json['new_arrivals'] as List?)?.map((e) => MoviesModel.fromJson(e)).toList() ?? [],
      upcomingMovies: (json['upcoming_movies'] as List?)?.map((e) => MoviesModel.fromJson(e)).toList() ?? [],
      slider: (json['slider'] as List?)?.map((e) => SliderItemModel.fromJson(e)).toList() ?? [],
      actors: (json['actors'] as List?)?.map((e) => ActorsModel.fromJson(e)).toList() ?? [],
      audios: (json['Audio'] as List?)?.map((e) => AudioModel.fromJson(e)).toList() ?? [],
      genre: (json['all_genres'] as List?)?.map((e) => GenreModel.fromJson(e)).toList() ?? [],
    );
  }
}
