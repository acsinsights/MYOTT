import 'package:get/get.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/services/api_endpoints.dart';
import 'package:myott/UI/Genre/Model/movie_by_genre_model.dart';
import '../../Model/Moviesmodel.dart';
import '../Model/genre_model.dart';
import '../movies_by_genre.dart';

class GenreController extends GetxController {
  final ApiService apiService = Get.find<ApiService>(); // Use Get.find() for dependency injection

  var selectedGenre = Rxn<GenreModel>();
  var moviesByGenre = <MoviesByGenreModel>[].obs;
  var isLoading = false.obs;

  void selectGenre(GenreModel genre) {
    if (selectedGenre.value?.id != genre.id) {
      // Only fetch if the selected genre is different
      selectedGenre.value = genre;
      fetchMoviesByGenre(genre.id);
    }
    Get.to(() => MoviesByGenre(), arguments: genre);
  }

  Future<void> fetchMoviesByGenre(int genreId) async {
    try {
      isLoading.value = true;
      final response = await apiService.get(APIEndpoints.moviesByGenre(genreId));

      if (response?.statusCode == 200 && response?.data != null) {
        final List<dynamic> data = response?.data;
        moviesByGenre.assignAll(data.map((e) => MoviesByGenreModel.fromJson(e)).toList());
        print(data.length);
        print(data.first);
      } else {
        print("Error: ${response?.statusCode} - ${response?.statusMessage}");
      }
    } catch (e, stacktrace) {
      print("Error fetching movies by genre: $e");
      print(stacktrace);
    } finally {
      isLoading.value = false;
    }
  }
}
