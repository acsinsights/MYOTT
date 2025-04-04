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

  Future<void> removeMovieFromWishlist(int id) async {
    bool removed = await wishlistService.removeMovieFromWatchlist(id: id);
    if (removed) {
      wishlist.removeWhere((item) => item.id == id); // Remove movie by id
    }
  }

  Future<void> removeSeriesFromWishlist(int id) async {
    bool removed = await wishlistService.removeSeriesFromWatchlist(id: id);
    if (removed) {
      wishlist.removeWhere((item) => item.id == id); // Remove series by id
    }
  }




}
