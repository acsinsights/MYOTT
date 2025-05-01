import 'package:myott/UI/Genre/Model/genre_model.dart';
import 'package:myott/UI/Actors/Model/ActorsModel.dart';
import 'package:myott/UI/Home/Model/HomeAudio.dart';
import 'package:myott/UI/Home/Model/HomeSeries.dart';
import 'package:myott/UI/Home/Model/videoModel.dart';
import '../../Model/Moviesmodel.dart';
import 'SliderItemModel.dart';
import 'latestMandTModel.dart';

class HomePageModel {
  final LatestMandTModel latest;  // Updated: Now properly included as a map
  final List<MoviesModel> top10;
  final List<MoviesModel> newArrival;
  final List<MoviesModel>? upcomingMovies;
  final List<SliderItemModel> slider;
  final List<ActorsModel> actors;
  final List<HomeSeries> series;
  final List<HomeAudio> audios;
  final List<Video> video;
  final List<HomeGenreModel> genre;

  HomePageModel({
    required this.latest,
    required this.top10,
    required this.newArrival,
    this.upcomingMovies,
    required this.slider,
    required this.series,
    required this.actors,
    required this.audios,
    required this.video,
    required this.genre,
  });

  factory HomePageModel.fromJson(Map<String, dynamic> json) {
    print("🎬 Raw latest: ${json['latest']}");

    return HomePageModel(
      latest: json['latest'] != null
          ? LatestMandTModel.fromJson(json['latest']) // Correct mapping for latest as a Map
          : LatestMandTModel(movies: [], series: []),  // Default to empty if null

      top10: (json['top_movies'] as List?)?.map((e) => MoviesModel.fromJson(e)).toList() ?? [],
      actors: (json['actors'] as List?)?.map((e) => ActorsModel.fromJson(e)).toList() ?? [],
      audios: (json['Audio'] as List?)?.map((e) => HomeAudio.fromJson(e)).toList() ?? [],

      newArrival: (json['new_arrivals'] as List?)?.map((e) => MoviesModel.fromJson(e)).toList() ?? [],
      upcomingMovies: (json['upcoming_movie'] as List?)?.map((e) => MoviesModel.fromJson(e)).toList() ?? [],
      slider: (json['slider'] as List?)?.map((e) => SliderItemModel.fromJson(e)).toList() ?? [],
      video: (json["videos"] as List?)?.map((e) => Video.fromJson(e)).toList() ?? [],

      series: (json["series"] as List?)?.map((e) => HomeSeries.fromJson(e)).toList() ?? [],
      genre: (json['all_genres'] as List?)?.map((e) => HomeGenreModel.fromJson(e)).toList() ?? [],
    );
  }
}
