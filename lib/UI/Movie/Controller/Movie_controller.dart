import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_common.dart';
import 'package:myott/services/commentService.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/MovieService.dart';
import '../../../services/wishlistService.dart';
import '../../Wishlist/Model/wishlistModel.dart';
import '../Model/movie_details_model.dart';

class MovieController extends GetxController {
  final MoviesService moviesService=MoviesService();
  CommentService commentService=CommentService();
  final WishlistService wishlistService = WishlistService();
  TextEditingController commentController = TextEditingController();

  var comments = <MovieComments>[].obs;
  RxBool isWishlisted = false.obs;
  RxList<Map<String, String>> wishlistItems = <Map<String, String>>[].obs;

  var isRated = false.obs;
  var isDownloaded = false.obs;

  var movieDetails = Rxn<MovieDetailsModel>(null);
  var isLoading = false.obs;
  RxBool isExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  static Future<void> shareReport(String movieUrl) async {
    try {
      await Share.share("Check out this report: $movieUrl");
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkWishlistStatus(String slug) async {
    try {
      List<WishlistModel> wishlist = await wishlistService.fetchWatchList();
      bool exists = wishlist.any((item) => item.movie.slug == slug);
      isWishlisted.value = exists;
    } catch (e) {
      print("Error fetching wishlist: $e");
    }
  }



  Future<void> fetchMovieDetails(String slug) async {
    try {
      isLoading.value = true;
      var fetchedMovieDetails = await moviesService.getMovieDetails(slug);

      if (fetchedMovieDetails != null) {
        movieDetails.value = fetchedMovieDetails;
        comments.assignAll(fetchedMovieDetails.comment);
      }
    } catch (e) {
      print("Error fetching movie details: $e");
    } finally {
      isLoading(false);
    }
  }
  Future<void> refreshMovieDetails() async {
    await fetchMovieDetails(movieDetails.value!.movie.slug);
  }



  Future<void> toggleWishlist(int movieId, String type) async {
    if (isWishlisted.value) {
      /// ✅ Remove from Wishlist
      showLoading();
      bool removed = await wishlistService.removeMovieFromWatchlist(id: movieId);
      print(movieId);
      if (removed) {
        isWishlisted.value = false; // Update UI
      }

      dismissLoading();
    } else {
      /// ✅ Add to Wishlist
      showLoading();
      bool added = await wishlistService.addToWishlist(
        type: type,
        id: movieId,
        value: 1,
      );
      if (added) {
        isWishlisted.value = true; // Update UI
      }
      dismissLoading();

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


  Future<void> addCommentForMovie(int movieId, String slug) async {
    if (commentController.text.trim().isEmpty) {
      Get.snackbar("Error", "Comment cannot be empty");
      return;
    }

    try {
      showLoading();
      Map<String, dynamic> formData = {
        "comment": commentController.text.trim(),
        "type": "M",
        "id": movieId
      };

      var response = await commentService.sendComment(formData);

      if (response != null && response['status'] == "success") {
        commentController.clear();
        showSnackbar("Success", response['message'] ?? "Comment added successfully");
        dismissLoading();

        fetchMovieDetails(slug);
      } else {
        showSnackbar("Error", response['message'] ?? "Failed to add comment",isError: true);
      }
    } catch (e) {
      print("Error adding comment: $e");
      showSnackbar("Error", "Something went wrong",isError: true);

    } finally {
      dismissLoading();
    }
  }
  Future<void>deleteCommentForMovie(int commentId,String slug) async {
    try {
      showLoading();
      Map<String, dynamic> formData = {
        "comment_id": commentId,
        "type": "M",
      };

      var response = await commentService.deleteComment(formData);

      if (response != null && response['status'] == "success") {
        commentController.clear();
        showSnackbar("Success", response['message'] ?? "Comment deleted successfully.");
        dismissLoading();

        fetchMovieDetails(slug);
      } else {
        showSnackbar("Error", response['message'] ?? "Failed to delete Comment.",isError: true);
      }
    } catch (e) {
      print("Error deleting comment: $e");
      showSnackbar("Error", "Something went wrong",isError: true);

    } finally {
      dismissLoading();
    }
  }

}
