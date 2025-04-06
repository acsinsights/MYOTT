import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Components/custom_button.dart';

import '../Home/Main_screen.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String transactionId;

  const PaymentSuccessScreen({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🖼️ Your OTT success image
            Image.asset(
              'assets/images/paymentSucces.png', // 👈 Replace with your path
              height: 240,
            ),

            const SizedBox(height: 32),

            // 🎉 Success Message
            const Text(
              "Payment Successful!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // 🧾 OTT-related subtext
            Text(
              "Your transaction ID is:\n$transactionId\n\nYou’ve unlocked premium entertainment. Sit back and enjoy binge-worthy content!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // 🚀 Explore More Button
            SizedBox(
              width: double.infinity,
              child: CustomButton(onPressed: (){
                Get.offAll(MainScreen());

              },text: "Explore More",),
            ),
          ],
        ),
      ),
    );
  }
}
