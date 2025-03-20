import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/services/MovieService.dart';
import 'package:myott/services/api_service.dart';

import '../../services/wishlistService.dart';

class WishlistController extends GetxController {
  final WishlistService wishlistService = WishlistService();
  final MovieController movieController=MovieController(MoviesService(ApiService()));

  var movies = <Map<String, dynamic>>[].obs;
  var tvSeries = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWishlistData();
  }

  // ✅ Wishlist Data Fetch
  Future<void> fetchWishlistData() async {
    isLoading.value = true;

    var wishlist = await wishlistService.fetchWishlistFromServer();

    List<int> movieIds = wishlist.where((item) => item["movie_id"] != null).map((e) => e["movie_id"] as int).toList();
    List<int> tvSeriesIds = wishlist.where((item) => item["tvseries_id"] != null).map((e) => e["tvseries_id"] as int).toList();

    print("🎬 Movie IDs: $movieIds");
    print("📺 TV Series IDs: $tvSeriesIds");

    var movieDetails = await wishlistService.fetchMovieDetails(movieIds);
    var tvSeriesDetails = await wishlistService.fetchTvSeriesDetails(tvSeriesIds);

    print("✅ Movie Details: $movieDetails");
    print("✅ TV Series Details: $tvSeriesDetails");

    movies.value = movieDetails;
    tvSeries.value = tvSeriesDetails;

    isLoading.value = false;
  }

  void removeFromWishlist(int itemId, String type) async {
    try {
      isLoading.value = true;

      final success = await wishlistService.removeFromWishlist(itemId, type);

      if (success) {
        if (type == "movie") {
          movies.removeWhere((item) => item["movie"]["id"] == itemId);
          movieController.wishlistItems.removeWhere((item) => item["id"] == itemId.toString());

          movies.refresh();
        } else {
          tvSeries.removeWhere((item) => item["series"]["id"] == itemId);
          movieController.wishlistItems.removeWhere((item) => item["id"] == itemId.toString());

          tvSeries.refresh();
        }
        await wishlistService.saveWishlist(movieController.wishlistItems);

        Get.snackbar("✅ Success", "Item removed from wishlist", backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("❌ Error", "Failed to remove item", backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("⚠️ Error", "Something went wrong", backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

}
