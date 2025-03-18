import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../PaymentGateways/PaymentSelectionScreen.dart';
import 'SubscriptionController.dart';
import 'Component/SubscriptionCard.dart';

class SubscriptionScreen extends StatelessWidget {
  final SubscriptionController controller = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Image.asset("assets/Icons/app_logo.png", height: 20),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.center,
              "Subscribe now and dive into endless streaming",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 16),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator(color: Colors.red));
                }
                if (controller.plans.isEmpty) {
                  return Center(child: Text("No subscription plans available", style: TextStyle(color: Colors.white)));
                }
                return ListView.builder(
                  itemCount: controller.plans.length,
                  itemBuilder: (context, index) {
                    return Obx(() => SubscriptionCard(
                      plan: controller.plans[index],
                      index: index,
                      isSelected: controller.selectedPlanIndex.value == index,
                      onSelect: () => controller.selectPlan(index),
                    ));
                  },
                );

              }),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Obx(() => controller.selectedPlanIndex.value != null
          ? Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Pay ${controller.plans[controller.selectedPlanIndex.value!].amount}",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
Get.to(PaymentSelectionScreen());                // Handle payment process
              },
              child: Text("Next", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      )
          : SizedBox.shrink(),
      ),
    );
  }
}
