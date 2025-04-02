import 'package:get/get.dart';
import 'package:myott/services/tv_series_service.dart';
import 'package:myott/UI/TvSeries/Model/TVSeriesDetailsModel.dart';
import 'package:myott/UI/TvSeries/Model/TvSeriesModel.dart';
import 'package:share_plus/share_plus.dart';

class TVSeriesController extends GetxController {
  final TVSeriesService _tvSeriesService =TVSeriesService();

  var isLoading = false.obs;
  var tvSeriesDetails = Rxn<SeriesDetailResponse>();
  var isDetailsLoading = true.obs;
  var isDownloaded = false.obs;
  var isWatchlisted = false.obs;
  var isLiked = false.obs;
  var isRated = false.obs;

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
      isDetailsLoading.value = true; // ✅ Use isDetailsLoading, not isLoading

      var fetchedTVSeriesDetails = await _tvSeriesService.fetchTVSeriesDetails(slug);
      if (fetchedTVSeriesDetails != null) {
        tvSeriesDetails.value = fetchedTVSeriesDetails;
      }
    } catch (e) {
      print("Error fetching TV Series Details: $e");
    } finally {
      isDetailsLoading.value = false;
    }
  }
  void shareContent(String title, String type, String url) {

    String message = "Check out this $type: $title\n$url";

    Share.share(message);
  }


  void toggleWatchlist() => isWatchlisted.value = !isWatchlisted.value;
  void toggleDownload() => isDownloaded.value = !isDownloaded.value;
  void toggleLike() => isLiked.value = !isLiked.value;
  void toggleRate() => isRated.value = !isRated.value;
}
