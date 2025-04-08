import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myott/services/tv_series_service.dart';
import 'package:myott/UI/TvSeries/Model/TVSeriesDetailsModel.dart';
import 'package:myott/UI/TvSeries/Model/TvSeriesModel.dart';
import 'package:myott/services/wishlistService.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Core/Utils/app_common.dart';
import '../../../services/commentService.dart';
import '../../Wishlist/Model/wishlistModel.dart';

class TVSeriesController extends GetxController {
  final TVSeriesService _tvSeriesService =TVSeriesService();
final WishlistService wishlistService=WishlistService();
CommentService commentService=CommentService();
  var comments = <SeriesComments>[].obs;

  var isLoading = false.obs;
  var tvSeriesDetails = Rxn<SeriesDetailResponse>();
  var isDetailsLoading = true.obs;
  var isDownloaded = false.obs;
  var isWishlisted = false.obs;
  var isLiked = false.obs;
  var isRated = false.obs;
  TextEditingController commentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    final String slug = Get.arguments?["slug"] ?? ""; // Fetch slug from arguments
    if (slug.isNotEmpty) {
      fetchTVSeriesDetails(slug);
    }
  }



  void fetchTVSeriesDetails(String slug) async {
    try {
      isLoading.value = true; // ✅ Use isDetailsLoading, not isLoading

      var fetchedTVSeriesDetails = await _tvSeriesService.fetchTVSeriesDetails(slug);
      if (fetchedTVSeriesDetails != null) {
        tvSeriesDetails.value = fetchedTVSeriesDetails;
        comments.assignAll(fetchedTVSeriesDetails.comments); // Initialize comments separately

      }
    } catch (e) {
      print("Error fetching TV Series Details: $e");
    } finally {
      isLoading(false);

    }
  }
  void shareContent(String title, String type, String url) {

    String message = "Check out this $type: $title\n$url";

    Share.share(message);
  }

  Future<void> checkWishlistStatus(String slug) async {
    try {
      List<WishlistModel> wishlist = await wishlistService.fetchWatchList();
      bool exists = wishlist.any((item) => item.series.slug == slug);
      isWishlisted.value = exists;
    } catch (e) {
      print("Error fetching wishlist: $e");
    }
  }
  Future<void> toggleWishlist(int movieId, String type) async {
    if (isWishlisted.value) {
      /// ✅ Remove from Wishlist
      showLoading();
      bool removed = await wishlistService.removeMovieFromWatchlist(id: movieId);
      if (removed) {
        isWishlisted.value = false; // Update UI
      }
      dismissLoading();

    } else {
      showLoading();

      /// ✅ Add to Wishlist
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
  void toggleDownload() => isDownloaded.value = !isDownloaded.value;
  void toggleLike() => isLiked.value = !isLiked.value;
  void toggleRate() => isRated.value = !isRated.value;


  Future<void> addCommentForSeries(int seriesId, String slug) async {
    if (commentController.text.trim().isEmpty) {
      Get.snackbar("Error", "Comment cannot be empty");
      return;
    }

    try {
      showLoading();

      Map<String, dynamic> formData = {
        "comment": commentController.text.trim(),
        "type": "T",
        "id": seriesId
      };

      var response = await commentService.sendComment(formData);

      if (response != null && response['status'] == "success") {
        commentController.clear();
        showSnackbar("Success", response['message'] ?? "Comment added successfully");
        dismissLoading();
        fetchTVSeriesDetails(slug);

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
  Future<void>deleteCommentForSeries(int commentId,String slug) async {
    try {
      showLoading();
      Map<String, dynamic> formData = {
        "comment_id": commentId,
        "type": "T",
      };

      var response = await commentService.deleteComment(formData);

      if (response != null && response['status'] == "success") {
        commentController.clear();
        showSnackbar("Success", response['message'] ?? "Comment deleted successfully.");
        dismissLoading();

        fetchTVSeriesDetails(slug);
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
