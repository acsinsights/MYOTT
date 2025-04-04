import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Components/custom_button.dart';
import '../../../../Core/Utils/app_common.dart';
import '../../../PaymentGateways/PaymentSelectionScreen.dart';
import 'SubscriptionController.dart';

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
        title: Image.asset("assets/Icons/app_logo.png", height: 24),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Text
            Text(
              "Choose a plan and start watching unlimited content!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Subscription Plans List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator(color: Colors.red));
                }
                if (controller.plans.isEmpty) {
                  return Center(
                      child: Text("No subscription plans available",
                          style: TextStyle(color: Colors.white)));
                }
                return ListView.builder(
                  itemCount: controller.plans.length,
                  itemBuilder: (context, index) {
                    var plan = controller.plans[index];
                    bool isSelected = controller.selectedPlanIndex.value == index;

                    return GestureDetector(
                      onTap: () {
                        controller.selectedPlanIndex.value = index;
                      },
                      child: Obx(() {
                        bool isSelected = controller.selectedPlanIndex.value == index;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Card(
                            color: Colors.grey[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: isSelected ? Colors.red : Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    plan.name,
                                    style: AppTextStyles.Heading1.copyWith(
                                      color: isSelected ? Colors.white : Colors.grey[300],
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time, color: Colors.white, size: 16),
                                      SizedBox(width: 5),
                                      Text(plan.planUnit.toUpperCase(), style: TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  ...List.generate(plan.features.length, (i) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.check_circle, color: Colors.green, size: 16),
                                          SizedBox(width: 5),
                                          Expanded(
                                            child: Text(
                                              plan.features[i],
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            plan.offerPrice != null ? "\$${plan.offerPrice}" : "\$${plan.amount}",
                                            style: TextStyle(
                                              color: Colors.yellow,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (plan.offerPrice != null)
                                            Text(
                                              "\$${plan.amount}",
                                              style: TextStyle(
                                                color: Colors.white60,
                                                fontSize: 14,
                                                decoration: TextDecoration.lineThrough,
                                              ),
                                            ),
                                        ],
                                      ),
                                      if (isSelected) Icon(Icons.check_circle, color: Colors.green, size: 24),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                );
              }),
            ),

            // Selected Plan Details + Next Button
            Obx(() {
              if (controller.selectedPlanIndex.value == null) {
                return SizedBox.shrink();
              }

              var plan = controller.plans[controller.selectedPlanIndex.value!];
              double displayedPrice = (plan.offerPrice ?? plan.amount).toDouble();
              String currencySymbol = controller.selectedCurrency.value == "USD" ? "\$" : "₹";

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Selected Plan Name
                  Text(
                    "Selected Plan: ${plan.name}",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),

                  // Total Amount to Pay
                  Text(
                    "Total Amount to Pay: $currencySymbol ${displayedPrice.toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.yellow, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  CustomButton(
                    width:double.infinity,
                    child: Text("Next", style: TextStyle(color: Colors.white, fontSize: 16)),
                   onPressed: () {
                    Get.to(PaymentSelectionScreen(), arguments: {
                      "paymentType": PaymentType.subscription.toString(),
                      "packageStatus": "active",
                      "package_id": plan.id,
                      "price": plan.amount,
                      "offer_price": plan.offerPrice,
                      "currency": plan.currency,
                    });
                  },),

                  // Next Button
                  // Center(
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.red,
                  //       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  //     ),
                  //     onPressed: () {
                  //       Get.to(PaymentSelectionScreen(), arguments: {
                  //         "paymentType": PaymentType.subscription.toString(),
                  //         "paymentStatus": "active",
                  //         "package_id": plan.id,
                  //         "price": plan.amount,
                  //         "offer_price": plan.offerPrice,
                  //         "currency": controller.selectedCurrency.value,
                  //       });
                  //     },
                  //     child: Text("Next", style: TextStyle(color: Colors.white, fontSize: 16)),
                  //   ),
                  // ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
