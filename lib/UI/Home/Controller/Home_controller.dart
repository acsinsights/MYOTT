import 'package:get/get.dart';
import 'package:myott/UI/Home/Model/Audio_Model.dart';
import 'package:myott/UI/Model/Moviemodel.dart';
import '../../../Services/Home_service.dart';
import '../Model/ActorsModel.dart';
import '../Model/genre_model.dart';

class HomeController extends GetxController {
  final HomeService _homeService; // ✅ Dependency Injection

  var latestMovies = <MoviesModel>[].obs;
  var topMovies = <MoviesModel>[].obs;
  var upcomingMovies = <MoviesModel>[].obs;
  var actors = <ActorsModel>[].obs;
  var audios = <LangModel>[].obs;
  var genre = <GenreModel>[].obs;
  var isLoading = false.obs;
  final List<int> colors = [
    0xFF3B3B98,
    0xFF8D4E3F,
    0xFF5D5D81,
    0xFF725285,
    0xFFA97E36,
    0xFF3B8D78,
    0xFF3B3B98,
    0xFF8D4E3F,
    0xFF5D5D81,
    0xFF725285,
    0xFFA97E36,
    0xFF3B8D78,
  ];


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
      isLoading(true);

      var homeData = await _homeService.fetchHomeData();

      latestMovies.assignAll(homeData["latest"] ?? []);
      topMovies.assignAll(homeData["top_movies"] ?? []);
      upcomingMovies.assignAll(homeData["upcoming_movie"] ?? []);
      actors.assignAll(homeData["actors"] ?? []);

      // ✅ Assign colors dynamically to audios (languages)
      List<LangModel> languageList = homeData["Audio"] ?? [];
      for (int i = 0; i < languageList.length; i++) {
        languageList[i].color = colors[i % colors.length]; // ✅ Assign color in a loop
      }
      audios.assignAll(languageList);

      List<GenreModel> genreList = homeData["all_genres"] ?? [];
      for (int i = 0; i < genreList.length; i++) {
        genreList[i].color = colors[i % colors.length]; // ✅ Assign color in a loop
      }
      genre.assignAll(genreList);

    } catch (e) {
      print("Error fetching home data: $e");
    } finally {
      isLoading(false);
    }
  }
}
