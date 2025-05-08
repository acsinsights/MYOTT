import 'package:get/get.dart';
import 'package:myott/UI/Home/Model/videoModel.dart';
import 'package:myott/UI/Video/Model/VideoDetailsModel.dart';
import 'package:myott/services/wishlistService.dart';
import 'package:share_plus/share_plus.dart';

import '../../../services/VideoService.dart';

class VideoDetailsController extends GetxController{
  final VideoService videoService=VideoService();
  final WishlistService wishlistService=WishlistService();
  var videoDetails = Rxn<VideoDetailsModel>(null);
  var videoOrder = Rxn<VOrder>(null);
  var isWishList = false.obs;
  var isRated = false.obs;
  var isLiked = false.obs;
  var isDownloaded = false.obs;
  var isPlaying = false.obs;
  var isLoading=false.obs;

  void fetchVideoDetails(String slug) async {
    try {
      isLoading(true);

      var fetchedVideoDetails = await videoService.getVideosDetails(slug);

      if(fetchedVideoDetails!=null){
        videoDetails.value = fetchedVideoDetails;
        videoOrder.value = fetchedVideoDetails.vOrder;
      }

    } catch (e) {
      print("Error fetching movie details: $e");
    } finally {
      isLoading(false);
    }
  }

  void shareContent(String title, String type, String url) {

    String message = "Check out this $type: $title\n$url";

    Share.share(message);
  }


  Future<void> toggleWishlist(int videoId, String type) async {
    if (isWishList.value) {
      bool removed = await wishlistService.removeMovieFromWatchlist(id: videoId);
      if (removed) {
        isWishList.value = false; // Update UI
      }
    } else {
      /// ✅ Add to Wishlist
      bool added = await wishlistService.addToWishlist(
        type: type,
        id: videoId,
        value: 1,
      );
      if (added) {
        isWishList.value = true; // Update UI
      }
    }
  }
  void toggleDownload() => isDownloaded.value = !isDownloaded.value;
  void toggleLike() => isLiked.value = !isLiked.value;
  void toggleRate() => isRated.value = !isRated.value;

}