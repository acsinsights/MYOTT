import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myott/UI/PaymentGateways/PaymentSelectionScreen.dart';

import '../../Core/Utils/app_common.dart';
import '../../video_player/component/Video_player_page.dart';
import '../Profile/Controller/ProfileController.dart';
import '../Profile/screens/SubscriptionPackage/subscription_page.dart';
import 'coin_bottomsheet.dart';
import 'custom_button.dart';     // <- Update with your actual path

class ContentAccessButton extends StatefulWidget {
  final bool isFree;
  final String selection; // 'subsriptionSystem', 'pricingSection', 'coinCostSection'
  final bool hasAccess;
  final String videoUrl;
  final Map<String,dynamic> subtitles; // adjust type if needed
  // final Map<String,dynamic> dubbedLanguages;
  final int? contentId;
  final int? contentCost;
  final String slug;
  final int? coinPrice;
  final int? planPrice;
  final int? offerPrice;
  final String? contentType;

   ContentAccessButton({
    Key? key,
    required this.isFree,
    required this.selection,
    required this.hasAccess,
    required this.videoUrl,
    required this.subtitles,
    this.contentId,
    this.contentCost,
    this.contentType,
     this.coinPrice,
     required this.slug,
    this.planPrice,
    this.offerPrice,
    // required this.dubbedLanguages,
  }) : super(key: key);

  @override
  State<ContentAccessButton> createState() => _ContentAccessButtonState();
}

class _ContentAccessButtonState extends State<ContentAccessButton> {
  late ProfileController profileController;

  @override
  void initState() {
    super.initState();
    profileController = Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isFree || widget.hasAccess) {
      return _buildPlayNowButton();
    }

    switch (widget.selection) {
      case 'subsriptionSystem':
        return _buildCustomButton("Subscribe to Watch", () {
          Get.to(SubscriptionScreen());
        });

      case 'pricingSection':
        return _buildCustomButton("Buy on Rent", () {
          Get.to(PaymentSelectionScreen(), arguments: {
            "paymentType": PaymentType.ppv.name,
            "price": widget.planPrice ?? 0,
            "offer_price": widget.offerPrice ?? 0,
            "content_id": widget.contentId ?? 0,
            "content_type": widget.contentType ?? "",
            "currency": "INR",
            "packageStatus": "active",
          });
        });

      case 'coinCostSection':
        return _buildCustomButton("Buy by Coins", () {
          final userCoins = profileController.user.value?.coins ?? 0;
          showCoinPurchaseSheet(
            price: widget.coinPrice ?? 0,
            slug: widget.slug,
            userCoins: userCoins,
            requiredCoins: widget.contentCost ?? 0,
            contentId: widget.contentId ?? 0,
            contentType: widget.contentType ?? "",
          );
        });

      default:
        return _buildCustomButton("Unavailable", () {});
    }
  }

  Widget _buildPlayNowButton() {
    return CustomButton(
      width: 180.w,
      text: "Play Now",
      onPressed: () {
        Get.to(VideoPlayerPage(
          videoUrl: widget.videoUrl,
          subtitles: widget.subtitles,
          dubbedLanguages: {},
        ));
      },
      backgroundColor: const Color(0xff290b0b),
      borderColor: Colors.white,
    );
  }

  Widget _buildCustomButton(String text, VoidCallback onPressed) {
    return CustomButton(
      width: 180.w,
      text: text,
      onPressed: onPressed,
      backgroundColor: const Color(0xff290b0b),
      borderColor: Colors.white,
    );
  }

  @override
  void dispose() {
    Get.delete<ProfileController>();
    super.dispose();
  }
}
