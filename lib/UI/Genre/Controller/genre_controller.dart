import 'package:get/get.dart';
import 'package:myott/services/GenreService.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/services/api_endpoints.dart';
import '../../Model/Moviesmodel.dart';
import '../Model/GenreMandTModel.dart';
import '../Model/genre_model.dart';
import '../movies_by_genre.dart';

class GenreController extends GetxController {
  final GenreService genreService = Get.put(GenreService(ApiService()));
  var selectedGenre = Rxn<HomeGenreModel>();
  var isLoading = false.obs;

  var movies=<GenreMovieModel>[].obs;
  var tvSeries=<GnereTvSeriesModel>[].obs;
  var videos=<GenreVideoModel>[].obs;
  var audios=<GenreAudioModel>[].obs;


  void selectGenre(HomeGenreModel genre) {
    if (selectedGenre.value?.id != genre.id) {
      selectedGenre.value = genre;
      fetchMoviesByGenre(genre.slug);
      print(genre.slug);
    }
    Get.to(() => MoviesByGenre(), arguments: genre);
  }



  void fetchMoviesByGenre(String genreSlug) async {
    try {
      isLoading.value = true;
      var data = await genreService.fetchMoviesByGenre(genreSlug);
      print("Fetched Data: $data"); // Debugging Line
      if (data != null) {
        movies.assignAll(data.movies ?? []);
        tvSeries.assignAll(data.tvSeries ?? []);
        videos.assignAll(data.videos ?? []);
        audios.assignAll(data.audios ?? []);

      } else {
        print("Failed to fetch genre movies");
      }
    } catch (e, stacktrace) {
      print("Error fetching movies by genre: $e");
      print(stacktrace);
    } finally {
      isLoading.value = false;
    }
  }
}
