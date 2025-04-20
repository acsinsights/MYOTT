import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/UI/Setting/Wallet/wallet_Screen.dart';
import 'package:myott/UI/Video/Controller/VideoDetailsController.dart';
import 'package:myott/services/PaymentGateway/payment_Gateway_service.dart';

import '../../Core/Utils/app_common.dart';
import '../PaymentGateways/PaymentSelectionScreen.dart';
import '../Profile/Controller/ProfileController.dart';
import '../TvSeries/Controller/tv_series_controller.dart';
import 'custom_button.dart'; // Your custom button

void showCoinPurchaseSheet({
  required int userCoins,
  required int requiredCoins,
  required String slug,
  required int price,
  required int contentId,
  required String contentType, // "movie" or "series"
}) {
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Unlock with Coins",
            style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Your Coins",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              Text("$userCoins",
                  style: TextStyle(color: Colors.yellow, fontSize: 16.sp)),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Required Coins",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              Text("$requiredCoins",
                  style: TextStyle(color: Colors.redAccent, fontSize: 16.sp)),
            ],
          ),
          SizedBox(height: 30.h),
          userCoins >= requiredCoins
              ? CustomButton(
                  text: "Buy Now",
                  onPressed: () {
                    Get.back(); // close sheet
                    _showCoinPurchaseConfirmDialog(
                      price: price,
                      slug: slug,
                      contentId: contentId,
                      contentType: contentType,
                    );
                  },
                )
              : CustomButton(
                  text: "Top Up Coins",
                  onPressed: () {
                    Get.back(); // close sheet
                    Get.to(() => WalletScreen());
                  },
                ),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

void _showCoinPurchaseConfirmDialog(
    {required int contentId,
    required String contentType,
    required String slug,
    required int price}) {
  Get.dialog(
    AlertDialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      actionsPadding: EdgeInsets.only(bottom: 16, right: 12),
      title: Text(
        "Confirm Purchase",
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8),
          Text(
            "Are you sure you want to buy this with your coins?",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          SizedBox(height: 20),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text("Cancel", style: TextStyle(color: Colors.grey[300])),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.back(); // Close dialog
            print(
                "🧾 DEBUG => contentId: $contentId, contentType: $contentType, slug: $slug, price: $price");

            await _callCoinPurchaseApi(
                contentId: contentId,
                contentType: contentType.toString(),
                slug: slug,
                price: price);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text("Yes, Buy", style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}

Future<void> _callCoinPurchaseApi({
  required String slug,
  required int contentId,
  required String contentType,
  required int price,
}) async {
  try {
    print(contentId);
    print(contentType);
    final data = {
      "content_id": contentId,
      "content_type": contentType,
      "price": price,
      "transaction_status": "success"
    };

    showLoading();

    final success = await PaymentGatewayService().buyMovieOrSeriesByCoins(data);


    if (success) {


      if (contentType == MediaType.movie.toString()) {
        final movieController = Get.put(MovieController());
        await movieController.refreshMovieDetails();
      }
      else if (contentType == MediaType.series.toString()) {
        final seriesController = Get.find<TVSeriesController>();
         seriesController.fetchTVSeriesDetails(slug);
      }
      else if(contentType == MediaType.video.toString()){
        final videoController = Get.find<VideoDetailsController>();
        videoController.fetchVideoDetails(slug);
      }
      Get.snackbar("Success", "🎉 Content Unlocked!",
          backgroundColor: Colors.green, colorText: Colors.white);
      final profileController = Get.find<ProfileController>();
      await profileController.refreshUser(); // 🔄 refresh user data
      dismissLoading();

    } else {
      Get.snackbar("Error", "⚠️ Failed to unlock content.",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  } catch (e, st) {
    dismissLoading();
    print("❌ Error in _callCoinPurchaseApi: $e");
    print("📍 Stacktrace: $st");

    Get.snackbar("Error", "Something went wrong!",
        backgroundColor: Colors.red, colorText: Colors.white);
  }
}
