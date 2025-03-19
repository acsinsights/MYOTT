import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/MovieService.dart';
import '../../../services/wishlistService.dart';
import '../Model/movie_details_model.dart';

class MovieController extends GetxController {
  final MoviesService moviesService;
  MovieController(this.moviesService);
  final WishlistService wishlistService = WishlistService();

  RxBool isWishlisted = false.obs;
  RxList<int> wishlistIds = <int>[].obs; // Wishlist movie IDs list

  var isRated = false.obs;
  var isDownloaded = false.obs;

  var movieDetails = Rxn<MovieDetailsModel>();
  var commentController = TextEditingController();
  var isLoading = false.obs;
  RxBool isExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadWishlistOnStartup();
  }

  Future<void> loadWishlistOnStartup() async {
    wishlistIds.value = await wishlistService.loadWishlist();
  }

  Future<void> toggleWishlist(int movieId, String type) async {
    int value = isWishlisted.value ? 0 : 1;

    bool success = await wishlistService.updateWishlist(
      id: movieId,
      type: type,
      value: value,
    );

    if (success) {
      isWishlisted.value = !isWishlisted.value;

      if (isWishlisted.value) {
        wishlistIds.add(movieId);
      } else {
        wishlistIds.remove(movieId);
      }
      await wishlistService.saveWishlist(wishlistIds);
    } else {
      Get.snackbar("Error", "Failed to update wishlist");
    }
  }

  void toggleRate() {
    isRated.value = !isRated.value;
  }

  void toggleDownload() {
    isDownloaded.value = !isDownloaded.value;
  }

  void fetchMovieDetails(int movieId) async {
    try {
      isLoading(true);

      var fetchedMovieDetails = await moviesService.getMovieDetails(movieId);

      isWishlisted.value = wishlistIds.contains(movieId);

      movieDetails.value = fetchedMovieDetails;
    } catch (e) {
      print("Error fetching movie details: $e");
    } finally {
      isLoading(false);
    }
  }
}
