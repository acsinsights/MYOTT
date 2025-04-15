import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myott/Core/Utils/app_colors.dart';
import 'package:myott/UI/Components/custom_text_field.dart';
import 'package:myott/UI/Components/custom_button.dart';
import 'package:myott/UI/Setting/Wallet/wallet_controller.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';

import '../../Profile/Controller/ProfileController.dart';
import 'Components/AlertRows.dart';

class WalletScreen extends StatefulWidget {
  WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final profileController = Get.put(ProfileController());
  final walletController = Get.put(WalletController());

  @override
  void initState() {
    profileController.fetchProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        title: Text("Wallet", style: AppTextStyles.Headingb4),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          children: [
            // Balance Container
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                padding: EdgeInsets.all(15.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color:AppColors.card,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.r,
                      spreadRadius: 5.r,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      final balance = profileController.user.value?.coins ?? 0.0;
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                        margin: EdgeInsets.only(bottom: 20.h),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                            color: Colors.greenAccent.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Current Balance",
                              style: AppTextStyles.SubHeading2
                            ),
                            Text(
                              "${balance.toInt()} Coins",
                              style: AppTextStyles.Headingb4.copyWith(
                                color: AppColors.yellow
                              )
                            ),
                          ],
                        ),
                      );
                    }),

                    Divider(color: theme.dividerColor.withOpacity(0.5)),

                    // Coins to credit
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "You will get",
                          style: AppTextStyles.SubHeading2

                        ),
                        Obx(() => Text(
                          "${walletController.coinsToCredit.value} Coins",
                          style: TextStyle(
                            color: Colors.amberAccent,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Add Money
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    controller: walletController.moneyController,
                    hintText: "0.00",
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                    width: double.infinity,
                    text: "Add Money to wallet",
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      walletController.proceedToPayment();
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // Alerts
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AlertRows(
                    icon: Icons.lock,
                    text: "Once the money is added in wallet its non-refundable.",
                  ),
                  AlertRows(
                    icon: Icons.star,
                    text: "You can use this money to purchase products on this portal.",
                  ),
                  AlertRows(
                    icon: Icons.info_rounded,
                    text: "Money will expire after 1 year from the credited date.",
                  ),
                  AlertRows(
                    icon: Icons.info_rounded,
                    text: "Wallet amount will always be added in default currency which is: INR",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    walletController.moneyController.clear();
    if (Get.isRegistered<WalletController>()) {
      Get.delete<WalletController>();
    }
    super.dispose();
  }
}
