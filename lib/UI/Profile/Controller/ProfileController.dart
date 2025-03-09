import 'package:get/get.dart';
import 'package:myott/services/Setting_service.dart';
import 'package:myott/UI/Movie/Controller/movie_controller.dart';
import 'package:myott/UI/Movie/Model/movie_model.dart';
import 'package:myott/UI/Profile/screens/SubscriptionPackage/Model/PackageModel.dart';

class ProfileController extends GetxController {
  final SettingService _settingService;
  ProfileController(this._settingService);
  var packageList = <PackageModel>[].obs;
  var isLoading = false.obs;

  // User details
  var userName = "John Doe".obs;
  var userEmail = "jhondoe123@gmail.com".obs;
  var userAvatar = "assets/images/actor1.png".obs;

  // Subscription details
  var subscriptionPlan = "Ultimate Plan".obs;
  var subscriptionExpiry = "03 May, 2025".obs;

  // Profiles list
  var profiles = <Map<String, String>>[
    {"name": "John Doe", "initials": "JO"},
    {"name": "Jane Doe", "initials": "JD"},
  ].obs;


  @override
  void onInit() {
    super.onInit();
    fetchPackages();
  }



  // Movies list (Fetched from MovieController)
  final movieController = Get.find<MovieController>(); // Get MovieController
  RxList<MovieModel> popularMovies = <MovieModel>[].obs;

  // void fetchPopularMovies() {
  //   // Fetch movies directly from MovieController
  //   popularMovies.assignAll(
  //     movieController.movies.where((movie) =>
  //     movie.imdbRating != null && movie.imdbRating > 8).toList(),
  //   );
  //
  //   // Listen for future changes
  //   ever(movieController.movies, (_) {
  //     popularMovies.assignAll(
  //       movieController.movies.where((movie) =>
  //       movie.imdbRating != null && movie.imdbRating > 8).toList(),
  //     );
  //   });
  // }
  Future<void> fetchPackages() async {
    try {
      isLoading(true);
      final data = await _settingService.fetchPackages();
      packageList.assignAll(data);
    } catch (e) {

    }
  }


}



