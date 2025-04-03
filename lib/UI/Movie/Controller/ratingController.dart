import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:myott/Core/Utils/app_colors.dart';
import 'package:myott/services/MovieService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Component/RatingBottomSheet.dart';

class RatingController extends GetxController {
  RxSet<int> ratedMovies = <int>{}.obs;
  var selectedRating = 0.obs;
  var reviewText = "".obs;
  final MoviesService movieService=MoviesService();



  @override
  void onInit() {
    loadRatedMovies();
  }

  Future<void> loadRatedMovies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedMovieIds = prefs.getStringList("rated_movies");
    if (storedMovieIds != null) {
      ratedMovies.addAll(storedMovieIds.map((id) => int.parse(id)));
    }
  }

  Future<void> saveRatedMovie(int movieId) async {
    ratedMovies.add(movieId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      "rated_movies",
      ratedMovies.map((id) => id.toString()).toList(),
    );
  }


  void openRatingSheet(int movieId, String type) {
    selectedRating.value = 0; // Reset previous rating
    reviewText.value = ""; // Reset review text

    Get.bottomSheet(
      RatingBottomSheet(
        movieId: movieId,
        type: type,
      ),
      isScrollControlled: true,
    );
  }

  Future<void> submitRating(int movieId, String type) async {
    if (selectedRating.value == 0) {
      Get.snackbar("Error", "Please select a rating before submitting!");
      return;
    }

    bool success = await movieService.rateMovie(
      movieId: movieId,
      type: type,
      review: reviewText.value,
      rating: selectedRating.value,
    );

    if (success) {
      Get.back();
      saveRatedMovie(movieId);
      Get.snackbar("Success", "Your rating has been submitted!",colorText: AppColors.white,backgroundColor: AppColors.green);
    } else {
      Get.snackbar("Error", "Failed to submit rating. Please try again.",colorText: AppColors.primary,backgroundColor: AppColors.green);
    }
  }
}
