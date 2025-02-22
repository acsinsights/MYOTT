import 'package:get/get.dart';
import '../../Data/movies_data.dart';
import '../Movie/Model/movie_model.dart';

class CustomSearchController extends GetxController {
  var searchHistory = <MovieModel>[].obs; // Stores the search history
  var popularMovies = <MovieModel>[].obs; // Stores popular movies
  var filteredMovies = <MovieModel>[].obs; // Stores search results

  @override
  void onInit() {
    loadPopularMovies();
    super.onInit();
  }

  // Load the popular movies (dummy data)
  void loadPopularMovies() {
    popularMovies.assignAll(allMovies);
  }

  // Add movie to search history
  void addToSearchHistory(MovieModel movie) {
    if (!searchHistory.any((m) => m.title == movie.title)) {
      searchHistory.insert(0, movie);
    }
  }

  // Remove movie from search history
  void removeFromSearchHistory(MovieModel movie) {
    searchHistory.removeWhere((m) => m.title == movie.title);
  }

  // Perform a search based on user input
  void searchMovies(String query) {
    if (query.isEmpty) {
      filteredMovies.clear();
      return;
    }
    filteredMovies.assignAll(
      allMovies.where((movie) => movie.title.toLowerCase().contains(query.toLowerCase())).toList(),
    );

    if (filteredMovies.isNotEmpty) {
      addToSearchHistory(filteredMovies.first);
    }
  }
}
