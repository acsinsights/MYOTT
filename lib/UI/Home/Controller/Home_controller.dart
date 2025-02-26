import 'package:get/get.dart';
import 'package:myott/UI/Home/Model/language_model.dart';
import 'package:myott/UI/Model/Moviemodel.dart';
import '../../../Services/Home_service.dart';
import '../Model/ActorsModel.dart';

class HomeController extends GetxController {
  final HomeService _homeService; // ✅ Dependency Injection

  var latestMovies = <MoviesModel>[].obs;
  var topMovies = <MoviesModel>[].obs;
  var upcomingMovies = <MoviesModel>[].obs;
  var actors = <ActorsModel>[].obs;
  var audios = <LangModel>[].obs;
  var isLoading = false.obs;

  // ✅ Constructor - Pass HomeService
  HomeController(this._homeService);

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  /// **✅ Fetch Home Data (Movies, Actors, Languages)**
  Future<void> fetchHomeData() async {
    try {
      isLoading(true); // Start Loading

      var homeData = await _homeService.fetchHomeData();

      latestMovies.assignAll(homeData["latest"] ?? []);
      topMovies.assignAll(homeData["top_movies"] ?? []);
      upcomingMovies.assignAll(homeData["upcoming_movie"] ?? []);
      actors.assignAll(homeData["actors"] ?? []);
      audios.assignAll(homeData["Audio"] ?? []);

    } catch (e) {
      print("Error fetching home data: $e");
    } finally {
      isLoading(false); // Stop Loading
    }
  }
}
