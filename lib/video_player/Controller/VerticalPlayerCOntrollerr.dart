import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_common.dart';
import 'package:video_player/video_player.dart';
import '../../Core/Utils/app_text_styles.dart';
import '../../UI/Components/coin_bottomsheet.dart';
import '../../UI/PaymentGateways/PaymentSelectionScreen.dart';
import '../../UI/Profile/Controller/ProfileController.dart';
import '../../UI/Profile/screens/SubscriptionPackage/subscription_page.dart';
import '../../UI/TvSeries/Model/TVSeriesDetailsModel.dart';

class VerticalPlayerControllerr extends GetxController {
  final currentIndex = 0.obs;
  final isInitialized = false.obs;
  final isLoading = true.obs;

  final ProfileController profileController = Get.put(ProfileController());

  Rxn<SeriesDetailResponse> seriesDetails = Rxn<SeriesDetailResponse>();
  Rxn<SOrder?> seriesOrder = Rxn<SOrder?>();
  Rxn<SeriesPackage> seriesPackage = Rxn<SeriesPackage>();
  var episodes = <Episode>[].obs;
  VideoPlayerController? videoController;

  void loadEpisodes(List<Episode> newEpisodes, SOrder? order, SeriesPackage package) {
    episodes.assignAll(newEpisodes);
    seriesOrder.value = order; // This is fine even if order is null
    seriesPackage.value = package;

    if (episodes.isNotEmpty) {
      initializeVideo(0);
    } else {
      isLoading.value = false;
      print("❌ No episodes available");
    }
  }

  void initializeVideo(int index) async {
    // Always pause and dispose the old video first
    await videoController?.pause();
    await videoController?.dispose();
    videoController = null;
    isInitialized.value = false;

    // Check episode index bounds
    if (episodes.isEmpty || index >= episodes.length) {
      print("❌ Episodes list is empty or index out of range: $index");
      return;
    }

    final episode = episodes[index];
    final bool isFree = episode.isFree ?? false;
    final bool hasAccess = isFree || checkHasAccess();

    if (!hasAccess) {
      showPremiumContentDialog();
      return;
    }

    try {
      currentIndex.value = index;
      videoController = VideoPlayerController.network(episode.uploadUrl);

      await videoController!.initialize();
      isInitialized.value = true;
      videoController!.play();

      update(); // Refresh UI
    } catch (e) {
      print("❌ Error initializing video: $e");
      isInitialized.value = false;
    }
  }

  void onPageChanged(int index) {
    initializeVideo(index);
  }

  bool checkHasAccess() {
    if (seriesOrder.value == null || seriesPackage.value == null) return false;

    final contentType = seriesPackage.value!.selection;
    if (contentType == "subsriptionSystem" || contentType == "pricingSection") {
      if (seriesOrder.value!.endDate == null) return false;
      return seriesOrder.value!.endDate!.isAfter(DateTime.now());
    }
    if (contentType == "coinCostSection") {
      return true;
    }
    return false;
  }

  void showPremiumContentDialog() {
    if (seriesPackage.value == null) {
      Get.snackbar("Error", "Package information not available", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    Get.dialog(
      AlertDialog(
        title: Text("Premium Content", style: AppTextStyles.Headingb4),
        content: Text("This content requires a purchase or subscription to access.", style: AppTextStyles.SubHeading2),
        actions: [
          TextButton(child: Text("Cancel"), onPressed: () => Get.back()),
          TextButton(child: Text("Get Access"), onPressed: () {
            Get.back();
            handlePremiumContent();
          }),
        ],
      ),
      barrierDismissible: false,
    );
  }
  void handlePremiumContent() {
    if (seriesPackage.value == null) {
      Get.snackbar("Error", "Package information not available", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final selection = seriesPackage.value!.selection;
    switch (selection) {
      case 'pricingSection':
        _openPaymentSelectionPage();
        break;
      case 'coinCostSection':
        _openCoinPurchaseSheet();
        break;
      case 'subsriptionSystem':
        _openSubscriptionPage();
        break;
      default:
        Get.snackbar("Error", "Invalid payment type", snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _openPaymentSelectionPage() {
    Get.to(() => PaymentSelectionScreen(), arguments: {
      "paymentType": PaymentType.ppv.name,
      "price": seriesPackage.value!.planPrice ?? 0,
      "offer_price": seriesPackage.value!.offerPrice ?? 0,
      "content_id": seriesDetails.value!.series.id ?? 0,
      "content_type": MediaType.series.name,
      "currency": "INR",
      "packageStatus": "active",
      "slug": seriesDetails.value!.series.slug ?? '',
    });
  }

  void _openCoinPurchaseSheet() {
    final userCoins = getUserCoins();

    showCoinPurchaseSheet(
      price: seriesPackage.value!.coinCost ?? 0,
      slug: seriesDetails.value!.series.slug ?? '',
      userCoins: userCoins,
      requiredCoins: seriesPackage.value!.coinCost ?? 0,
      contentId: seriesDetails.value!.series.id ?? 0,
      contentType: MediaType.series.name,
    );
  }

  void _openSubscriptionPage() {
    Get.to(() => SubscriptionScreen(),
    arguments: {

      "content_id": seriesDetails.value!.series.id ?? 0,
      "content_type": MediaType.series.name,
      "slug": seriesDetails.value!.series.slug ?? '',
    }
    );
  }

  int getUserCoins() {
    final userCoins = profileController.user.value?.coins ?? 0;
    return userCoins;
  }
  @override
  void onClose() {
    videoController?.dispose();
    super.onClose();
  }
}
