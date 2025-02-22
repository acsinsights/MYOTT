import 'package:get/get.dart';
import 'package:myott/UI/Movie/Controller/movie_controller.dart';
import 'package:myott/UI/Movie/Model/movie_model.dart';

class ProfileController extends GetxController {
  // User details
  var userName = "John Doe".obs;
  var userEmail = "jhondoe123@gmail.com".obs;
  var userAvatar = "assets/images/actor1.png".obs;

  // Subscription details
  var subscriptionPlan = "Ultimate Plan".obs;
  var subscriptionExpiry = "03 May, 2025".obs;

  // Profiles list
  var profiles = <Map<String, String>>[
    {"name": "John Doe", "initials": "JO"},
    {"name": "Jane Doe", "initials": "JD"},
  ].obs;

  // Movies list (Fetched from MovieController)
  final movieController = Get.find<MovieController>(); // Get MovieController
  RxList<MovieModel> popularMovies = <MovieModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPopularMovies();
  }

  void fetchPopularMovies() {
    // Fetch movies directly from MovieController
    popularMovies.assignAll(
      movieController.movies.where((movie) => movie.imdbRating != null && movie.imdbRating > 8).toList(),
    );

    // Listen for future changes
    ever(movieController.movies, (_) {
      popularMovies.assignAll(
        movieController.movies.where((movie) => movie.imdbRating != null && movie.imdbRating > 8).toList(),
      );
    });
  }
}
