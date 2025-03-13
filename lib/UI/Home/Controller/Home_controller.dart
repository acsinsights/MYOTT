import 'dart:ui';

import 'package:get/get.dart';
import 'package:myott/UI/Home/Model/Audio_Model.dart';
import 'package:myott/UI/Home/Model/SliderItemModel.dart';
import 'package:myott/UI/Model/Moviesmodel.dart';
import '../../../services/Home_service.dart';
import '../../Actors/Model/ActorsModel.dart';
import '../../Genre/Model/genre_model.dart';
import '../Model/HomePageModel.dart';

class HomeController extends GetxController {
  final HomeService _homeService; // ✅ Dependency Injection

  var homePageData = Rxn<HomePageModel>();

  var isLoading = false.obs;

  // ✅ Constructor - Pass HomeService
  HomeController(this._homeService);

  @override
  void onInit() {
    super.onInit();
    fetchHomePageData();
  }
  Future<void> fetchHomePageData() async {
    try {
      isLoading(true);

      final HomePageModel? data = await _homeService.fetchHomePageData();

      if (data != null) {
        homePageData.value = data;

      } else {
        print("No data received from API");
      }
    } catch (e) {
      print("Error fetching HomePage data: $e");
    } finally {
      isLoading(false);
    }
  }



}
