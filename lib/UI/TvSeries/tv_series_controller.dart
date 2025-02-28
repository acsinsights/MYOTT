import 'package:get/get.dart';
import 'package:myott/Services/tv_series_service.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import 'package:myott/UI/TvSeries/Model/TvSeriesModel.dart';

class TVSeriesController extends GetxController {
  final TVSeriesService tvSeriesService;
  TVSeriesController(this.tvSeriesService);

  var tvSeries = <TvSeriesModel>[].obs;
  var isLoading = true.obs;
  var selectedTvSeries = Rxn<TvSeriesModel>(); // Stores the selected movie


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
  void selectTVSeries(TvSeriesModel series) {
    selectedTvSeries.value = series; // Assign selected TV show
    Get.to(TvSeriesPage());
  }
}
