import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/PaymentGateways/Controller/PaymentGatewayController.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/services/payment_service.dart';
import 'package:myott/services/setting_service.dart';

import 'Model/PackageModel.dart';


class SubscriptionController extends GetxController {
  final SettingService settingService = Get.put(SettingService(ApiService()));
  final PaymentGatewayController paymentGatewayController=Get.put(PaymentGatewayController());

  var plans = <PackageModel>[].obs;
  var isLoading = true.obs;
  var selectedPlanIndex = Rxn<int>();

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionPlans();
  }

  Future<void> fetchSubscriptionPlans() async {
    try {
      isLoading.value = true;
      final fetchedPlans = await settingService.fetchPackages();
      if (fetchedPlans.isNotEmpty) {
        plans.assignAll(fetchedPlans);
      }
    } catch (e) {
      print("Error fetching plans: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void selectPlan(int index) {
    selectedPlanIndex.value = index;
  }

  void proceedToPayment() {
    if (selectedPlanIndex.value == null) {
      Get.snackbar("Error", "Please select a subscription plan first",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final selectedPlan = plans[selectedPlanIndex.value!];

    paymentGatewayController.initiatePayment(
      amount: selectedPlan.amount.toString(),
      currency: "INR",
    );
  }

  @override
  void onClose() {
    paymentGatewayController.dispose();
    super.onClose();
  }
}
