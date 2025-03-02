import 'package:get/get.dart';
import 'package:myott/Services/tv_series_service.dart';
import 'package:myott/UI/TvSeries/Model/TVSeriesDetailsModel.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import 'package:myott/UI/TvSeries/Model/TvSeriesModel.dart';

class TVSeriesController extends GetxController {
  final TVSeriesService tvSeriesService;
  TVSeriesController(this.tvSeriesService);

  var tvSeries = <TvSeriesModel>[].obs;
  var tvSeriesDetails = Rxn<TvSeriesDetailsModel>(); // Stores the details

  var isLoading = true.obs;


  @override
  void onInit() {
    fetchTVSeries();
    super.onInit();
  }

  void fetchTVSeries() async {
    try {
      isLoading.value = true;
      var fetchedSeries = await tvSeriesService.fetchTVSeries();

      if (fetchedSeries.isNotEmpty) {
        tvSeries.assignAll(fetchedSeries);
      } else {
        print("No TV Series available or empty response.");
      }
    } catch (e) {
      print("Error in fetching TV Series: $e");
    } finally {
      isLoading.value = false;
    }
  }
  void fetchTVSeriesDetails(int seriesId) async {
    try {
      isLoading.value = true;
      var details = await tvSeriesService.fetchTVSeriesDetails(seriesId);
      tvSeriesDetails.value = details;
    } catch (e) {
      print("Error fetching TV Series Details: $e");
    } finally {
      isLoading.value = false;
    }
  }


}
