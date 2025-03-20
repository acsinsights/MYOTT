import 'package:get/get.dart';
import 'package:myott/services/tv_series_service.dart';
import 'package:myott/UI/TvSeries/Model/TVSeriesDetailsModel.dart';
import 'package:myott/UI/TvSeries/Model/TvSeriesModel.dart';

class TVSeriesController extends GetxController {
  final TVSeriesService _tvSeriesService;

  TVSeriesController(this._tvSeriesService);

  // TV Series List
  var tvSeries = <TvSeriesModel>[].obs;
  var isLoading = true.obs;

  // TV Series Details
  var tvSeriesDetails = Rxn<TvSeriesDetailsModel>();
  var isDetailsLoading = true.obs;

  // Watchlist & Like State
  var isWatchlisted = false.obs;
  var isLiked = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTVSeries();
  }

  /// Fetches the list of TV Series
  void fetchTVSeries() async {
    try {
      isLoading.value = true;
      var fetchedSeries = await _tvSeriesService.fetchTVSeries();

      if (fetchedSeries.isNotEmpty) {
        tvSeries.assignAll(fetchedSeries);
      } else {
        print("No TV Series available.");
      }
    } catch (e) {
      print("Error fetching TV Series: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void fetchTVSeriesDetails(int seriesId) async {
    try {
      isDetailsLoading.value = true;
      tvSeriesDetails.value = await _tvSeriesService.fetchTVSeriesDetails(seriesId);
    } catch (e) {
      print("Error fetching TV Series Details: $e");
    } finally {
      isDetailsLoading.value = false;
    }
  }

  /// Toggles the Watchlist status
  void toggleWatchlist() => isWatchlisted.value = !isWatchlisted.value;

  /// Toggles the Like status
  void toggleLike() => isLiked.value = !isLiked.value;
}
