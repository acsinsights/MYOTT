import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final profileController = Get.find<ProfileController>();
  WalletController walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.black,
        title: Text("Wallet", style: AppTextStyles.Headingb4),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            // Balance Container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF3C3939),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 5)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Current Balance
                    Obx(() {
                      final balance = profileController.user.value?.coins ?? 0.0;
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFF242323),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Current Balance", style: TextStyle(color: Colors.white70, fontSize: 14)),
                            Text(
                              "${balance.toInt()} Coins", // Displaying integer value
                              style: TextStyle(color: Colors.amberAccent, fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    }),

                    Divider(color: Colors.white.withOpacity(0.5)),

                    // Coins to credit
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("You will get", style: TextStyle(color: Colors.white60, fontSize: 14)),
                        Obx(() => Text(
                          "${walletController.coinsToCredit.value} Coins",
                          style: TextStyle(color: Colors.amberAccent, fontSize: 24, fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Add Money to Wallet Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    controller: walletController.moneyController,
                    hintText: "0.00",
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    width: double.infinity,
                    text: "Add Money to wallet",
                    backgroundColor: Colors.black,
                    borderColor: Colors.red,
                    onPressed: () {
                      walletController.proceedToPayment();
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Alerts Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
