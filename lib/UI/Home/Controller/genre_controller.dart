import 'package:get/get.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import '../../Movie/Controller/Movie_controller.dart';
import '../../Movie/Model/movie_model.dart';
import '../Model/genre_model.dart';
import '../movies_by_genre.dart';

class GenreController extends GetxController {
  var selectedGenre = Rxn<GenreModel>();
  var moviesByGenre = <MovieModel>[].obs; // Store movies filtered by language


  final List<GenreModel> genres = [
    GenreModel(name: "Action",  image: "assets/images/language/lang1.png", color: 0xFF3B3B98),
    GenreModel(name: "Drama", image: "assets/images/language/lang2.png", color: 0xFF8D4E3F),
    GenreModel(name: "Comedy",  image: "assets/images/language/lang3.png", color: 0xFF5D5D81),
    GenreModel(name: "Series",image: "assets/images/language/lang4.png", color: 0xFF725285),
    GenreModel(name: "Horror", image: "assets/images/language/lang5.png", color: 0xFFA97E36),
    GenreModel(name: "Biopic", image: "assets/images/language/lang6.png", color: 0xFF3B8D78),
  ];

  void selectGenre(GenreModel genre) {
    selectedGenre.value = genre;
    MovieController movieController = Get.find<MovieController>();
    moviesByGenre.assignAll(
      movieController.movies.where((movie) => movie.genres.contains(genre.name)).toList(),
    );
    Get.to(MoviesByGenre(), arguments: genre);
  }
}
