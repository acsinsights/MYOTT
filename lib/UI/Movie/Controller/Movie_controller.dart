import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myott/services/commentService.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/MovieService.dart';
import '../../../services/wishlistService.dart';
import '../Model/movie_details_model.dart';

class MovieController extends GetxController {
  final MoviesService moviesService;
  CommentService commentService=CommentService();
  MovieController(this.moviesService);
  final WishlistService wishlistService = WishlistService();

  RxBool isWishlisted = false.obs;

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
  RxList<Map<String, String>> wishlistItems = <Map<String, String>>[].obs;

  static Future<void> shareReport(String movieUrl) async {
    try {
      await Share.share("Check out this report: $movieUrl");
    } catch (e) {
      print(e);
    }
  }


  Future<void> loadWishlistOnStartup() async {
    List<Map<String, dynamic>> rawWishlist = await wishlistService.loadWishlist();

    wishlistItems.value = rawWishlist.map((item) {
      return {
        "id": item["id"].toString(),
        "type": item["type"].toString(),
      };
    }).toList();
  }

    Future<void> toggleWishlist(int movieId, String type) async {
    int value = isWishlisted.value ? 0 : 1; // 1 -> Add, 0 -> Remove

    bool success = await wishlistService.updateWishlist(
      id: movieId,
      type: type,
      value: value,
    );

    if (success) {
      isWishlisted.value = !isWishlisted.value; // Toggle UI state

      if (isWishlisted.value) {
        wishlistItems.add({"id": movieId.toString(), "type": type});
      } else {
        wishlistItems.removeWhere((item) => item["id"] == movieId.toString());
      }

      await wishlistService.saveWishlist(wishlistItems);
    } else {
      Get.snackbar("Error", "Failed to update wishlist");
    }
  }

  void fetchMovieDetails(int movieId,String slug) async {
    try {
      isLoading(true);

      var fetchedMovieDetails = await moviesService.getMovieDetails(slug);

      isWishlisted.value = wishlistItems.any((item) => item["id"] == movieId.toString());

      movieDetails.value = fetchedMovieDetails;
    } catch (e) {
      print("Error fetching movie details: $e");
    } finally {
      isLoading(false);
    }
  }

  void toggleRate() {
    isRated.value = !isRated.value;

  }


  void toggleDownload() {
    isDownloaded.value = !isDownloaded.value;
  }
  void shareContent(String title, String type, String url) {

    String message = "Check out this $type: $title\n$url";

    Share.share(message);
  }


  Future<void>addCommentForMovie(String comment,int movieId)async{
    try {
      isLoading(true);
      Map<String,dynamic> formdata={
        "comment":commentController.text.toString(),
        "type":"M",
        "id":movieId
       };
      var response = await commentService.sendComment(formdata);
      isLoading(false);
    }catch(e){

    }finally{
      isLoading(false);
    }
  }
}
