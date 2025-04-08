import 'package:get/get.dart';
import 'package:myott/UI/Wishlist/Model/wishlistModel.dart';
import 'package:myott/services/wishlistService.dart';

import '../../Core/Utils/app_common.dart';

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

  List<WishlistMovie> get movies {
    return wishlist
        .where((item) => item.movie != null && item.movie.name.isNotEmpty)
        .map((item) => item.movie)
        .toList();
  }

  List<WishlistSeries> get tvSeries {
    return wishlist
        .where((item) => item.series != null && item.series.name.isNotEmpty)
        .map((item) => item.series)
        .toList();
  }
  List<WishlistAudio> get audios {
    return wishlist
        .where((item) => item.audio != null && item.audio.name.isNotEmpty)
        .map((item) => item.audio)
        .toList();
  }

  List<WishlistVideo> get videos {
    return wishlist
        .where((item) => item.video != null && item.video.name.isNotEmpty)
        .map((item) => item.video)
        .toList();
  }

  Future<void> removeMovieFromWishlist(int id) async {
    showLoading();
    bool removed = await wishlistService.removeMovieFromWatchlist(id: id);
    if (removed) {
      wishlist.removeWhere((item) => item.id == id); // Remove movie by id
    }
    dismissLoading();
  }

  Future<void> removeSeriesFromWishlist(int id) async {
    showLoading();

    bool removed = await wishlistService.removeSeriesFromWatchlist(id: id);
    if (removed) {
      wishlist.removeWhere((item) => item.id == id); // Remove series by id
    }
    dismissLoading();

  }

  Future<void> removeAudioFromWishlist(int id) async {
    showLoading();

    bool removed = await wishlistService.removeAudioFromWatchlist(id: id);
    if (removed) {
      wishlist.removeWhere((item) => item.audio != null && item.audio.id == id);
    }
    dismissLoading();

  }

  Future<void> removeVideoFromWishlist(int id) async {
    showLoading();

    bool removed = await wishlistService.removeVideoFromWatchlist(id: id);
    if (removed) {
      wishlist.removeWhere((item) => item.video != null && item.video.id == id);
    }
    dismissLoading();

  }





}
