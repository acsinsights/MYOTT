import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import '../../../Data/movies_data.dart';
import '../../../Services/MovieService.dart';
import '../../Model/Moviemodel.dart';
import '../Model/movie_model.dart';

class MovieController extends GetxController {
  var movies = <MovieModel>[].obs; // Main list of movies
  var isLoading = true.obs;
  var currentPage = 0.obs; // Observable for the current page
  late PageController pageController;
  var selectedMovie = Rxn<MoviesModel>(); // Stores the selected movie

  @override
  void onInit() {
    pageController = PageController(viewportFraction: 0.9);
    fetchMovies();
    _autoScroll();
    super.onInit();
  }

  void fetchMovies() {
    movies.assignAll(allMovies);
    isLoading.value = false;
  }
  List<MovieModel> get featuredMovies =>
      movies.where((movie) => movie.isFeatured).toList();

  List<MovieModel> get latestMovies =>
      movies.where((movie) => movie.releaseDate != null).toList();

  List<MovieModel> get trendingMovies =>
      movies.where((movie) => movie.isTrending).toList();





  List<MovieModel> getMoviesByGenre(String genre) =>
      movies.where((movie) => movie.genres.contains(genre)).toList();

  List<MovieModel> getMoviesByLanguage(String language) =>
      movies.where((movie) => movie.languages.contains(language)).toList();

  List<MovieModel> searchMovies(String query) {
    return movies.where((movie) => movie.title.toLowerCase().contains(query.toLowerCase())).toList();
  }


  void updatePage(int index) {
    currentPage.value = index;
  }

  void _autoScroll() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (pageController.hasClients) {
        int nextPage = currentPage.value + 1;
        if (nextPage >= featuredMovies.length) {
          nextPage = 0;
        }
        pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        currentPage.value = nextPage;
      }
    });
  }

  // void setSelectedMovie(MovieModel movie) {
  //   selectedMovie.value = movie;
  //   Get.to(MovieDetailScreen(),arguments: movie); // Navigate to the Movie Details Page
  // }

  // void fetchMovieDetails(int movieId) async {
  //   try {
  //     var movie = await MoviesModelService.getMovieDetails(movieId);
  //     selectedMovie.value = movie;
  //     Get.to(() => MovieDetailScreen(),arguments: movie);
  //   } catch (e) {
  //     print("Error fetching movie details: $e");
  //   }
  // }
}
