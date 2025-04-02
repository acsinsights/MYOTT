import 'package:get/get.dart';
import 'package:myott/UI/Wishlist/Model/wishlistModel.dart';
import 'package:myott/services/wishlistService.dart';

class WishlistController extends GetxController {
  final WishlistService wishlistService = WishlistService();

  var wishlist = <WishlistModel>[].obs; // Keep the RxList of WishlistModel
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWishlistData();
  }

  Future<void> fetchWishlistData() async {
    isLoading.value = true;

    var response = await wishlistService.fetchWatchList();

    if (response != null && response.isNotEmpty) {
      wishlist.clear();
      wishlist.addAll(response);
    } else {
      print("No data or empty list returned"); // Debugging line
    }

    isLoading.value = false;
  }

  List<Movie> get movies {
    return wishlist
        .where((item) => item.movie != null && item.movie.name.isNotEmpty)
        .map((item) => item.movie)
        .toList();
  }

  List<Series> get tvSeries {
    return wishlist
        .where((item) => item.series != null && item.series.name.isNotEmpty)
        .map((item) => item.series)
        .toList();
  }

  Future<void> removeMovieFromWishlist(String movieSlug) async {
    WishlistModel? wishlistItem = wishlist.firstWhereOrNull((item) => item.movie.slug == movieSlug);

    if (wishlistItem != null) {
      print(wishlistItem.id);
      bool removed = await wishlistService.removeMovieFromWatchlist(id: wishlistItem.id);

      if (removed) {
        wishlist.remove(wishlistItem); // Remove the whole wishlist entry
      }
    }
  }

  Future<void> removeSeriesFromWishlist(String seriesSlug) async {
    WishlistModel? wishlistItem = wishlist.firstWhereOrNull((item) => item.series.slug == seriesSlug);

    if (wishlistItem != null) {
      bool removed = await wishlistService.removeSeriesFromWatchlist(id: wishlistItem.id);
      if (removed) {
        wishlist.remove(wishlistItem); // Remove the whole wishlist entry
      }
    }
  }



}
