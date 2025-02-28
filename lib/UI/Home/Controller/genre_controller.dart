import 'package:get/get.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import '../../Movie/Controller/Movie_controller.dart';
import '../../Movie/Model/movie_model.dart';
import '../Model/genre_model.dart';
import '../movies_by_genre.dart';

class GenreController extends GetxController {
  var selectedGenre = Rxn<GenreModel>();
  var moviesByGenre = <MovieModel>[].obs; // Store movies filtered by language



  void selectGenre(GenreModel genre) {
    selectedGenre.value = genre;
    MovieController movieController = Get.find<MovieController>();
    moviesByGenre.assignAll(
      movieController.movies.where((movie) => movie.genres.contains(genre.name)).toList(),
    );
    Get.to(MoviesByGenre(), arguments: genre);
  }
}
