import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Home/Model/HomePageModel.dart';
import '../../../services/Home_service.dart';

class HomeController extends GetxController {
  final HomeService _homeService =HomeService();

  var homePageData = Rx<HomePageModel?>(null);
  var isLoading = false.obs;
  var errorMessage = RxnString();


  @override
  void onInit() {
    super.onInit();
    fetchHomePageData();
  }

  Future<void> fetchHomePageData() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      final HomePageModel? data = await _homeService.fetchHomePageData();

      if (data != null) {
        homePageData.value = data;
        debugPrint("✅ Home Page Data Loaded Successfully");
      } else {
        errorMessage.value = "No data available.";
        debugPrint("⚠️ No data received from API");
      }
    } on SocketException {
      errorMessage.value = "No internet connection.";
      debugPrint("🚨 Network error: No internet connection.");
    } on TimeoutException {
      errorMessage.value = "Request timed out. Please try again.";
      debugPrint("⏳ Request timed out.");
    } catch (e) {
      errorMessage.value = "Something went wrong. Please try again.";
      debugPrint("❌ Error fetching HomePage data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshHomePage() async {
    await fetchHomePageData();
  }
}