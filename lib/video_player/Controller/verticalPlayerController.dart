import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/TvSeries/Model/TVSeriesDetailsModel.dart';
import 'package:video_player/video_player.dart';

import '../../Core/Utils/app_common.dart';
import '../../UI/Components/coin_bottomsheet.dart';
import '../../UI/PaymentGateways/PaymentSelectionScreen.dart';
import '../../UI/Profile/screens/SubscriptionPackage/subscription_page.dart';

class VerticalPlayerController extends GetxController {
  final currentIndex = 0.obs;
  final showPlayPauseIcon = false.obs;
  final isInitialized = false.obs;

  List<Episode> episodes = [];
  List<VideoPlayerController> controllers = [];
  SeriesPackage? seriesPackage;
  SOrder? order;
  String? slug;
  int? contentId;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> initData(List<Episode> epList, SeriesPackage? seriesPackage, SOrder? order, String? slug, int? contentId) async {
    this.episodes = epList;
    this.seriesPackage = seriesPackage;
    this.order = order;
    this.slug = slug;
    this.contentId = contentId;

    await _initializeControllers();
    isInitialized.value = true;
    playVideo(currentIndex.value);
  }

  Future<void> _initializeControllers() async {
    // Dispose old controllers
    for (var controller in controllers) {
      await controller.pause();
      controller.dispose();
    }

    controllers.clear();
    controllers = episodes.map((ep) => VideoPlayerController.network(ep.uploadUrl)).toList();

    await Future.wait(controllers.map((c) => c.initialize()));
  }

  bool checkHasAccess() {
    if (order == null || seriesPackage == null) return false;

    final contentType = seriesPackage!.selection;
    if (contentType == "subsriptionSystem" || contentType == "pricingSection") {
      if (order!.endDate == null) return false;
      return order!.endDate!.isAfter(DateTime.now());
    }
    if (contentType == "coinCostSection") {
      return true;
    }
    return false;
  }

  void playVideo(int index) {
    if (index >= controllers.length || !isInitialized.value) return;

    for (var controller in controllers) {
      controller.pause();
    }

    final ep = episodes[index];
    if (ep.isFree == true || checkHasAccess()) {
      controllers[index].play();
    } else {
      showPremiumContentDialog();
    }
  }

  bool isPlaying(int index) {
    if (index >= controllers.length) return false;
    return controllers[index].value.isPlaying;
  }

  void togglePlayPause(int index) {
    if (index >= controllers.length || !isInitialized.value) return;

    final controller = controllers[index];
    final episode = episodes[index];

    showPlayPauseIcon.value = true;
    Future.delayed(Duration(seconds: 1), () {
      showPlayPauseIcon.value = false;
    });

    if (episode.isFree || checkHasAccess()) {
      if (controller.value.isPlaying) {
        controller.pause();
      } else {
        controller.play();
      }
    } else {
      showPremiumContentDialog();
    }
  }

  void showPremiumContentDialog() {
    if (seriesPackage == null) {
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
    if (seriesPackage == null) {
      Get.snackbar("Error", "Package information not available", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final selection = seriesPackage!.selection;
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
      "price": seriesPackage!.planPrice ?? 0,
      "offer_price": seriesPackage!.offerPrice ?? 0,
      "content_id": contentId ?? 0,
      "content_type": MediaType.series.name,
      "currency": "INR",
      "packageStatus": "active",
    });
  }

  void _openCoinPurchaseSheet() {
    final userCoins = getUserCoins();

    showCoinPurchaseSheet(
      price: seriesPackage!.coinCost ?? 0,
      slug: slug ?? '',
      userCoins: userCoins,
      requiredCoins: seriesPackage!.coinCost ?? 0,
      contentId: contentId ?? 0,
      contentType: MediaType.series.name,
    );
  }

  void _openSubscriptionPage() {
    Get.to(() => SubscriptionScreen());
  }

  int getUserCoins() {
    return 0; // Replace with actual implementation
  }

  void onPageChanged(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
      playVideo(index);
    }
  }

  @override
  void onClose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
