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
  var selectedGenre = Rxn<GenreModel>();
  var mAndtGenre = Rxn<GenreMandTModel>();
  var isLoading = false.obs;

  void selectGenre(GenreModel genre) {
    if (selectedGenre.value?.id != genre.id) {
      selectedGenre.value = genre;
      fetchMoviesByGenre(genre.id);
    }
    Get.to(() => MoviesByGenre(), arguments: genre);
  }

  void fetchMoviesByGenre(int genreId) async {
    try {
      isLoading.value = true;
      var data = await genreService.fetchMoviesByGenre(genreId);
      if (data != null) {
        mAndtGenre.value = data;
      }else {
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
