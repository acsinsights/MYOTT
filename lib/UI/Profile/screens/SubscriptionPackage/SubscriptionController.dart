import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/PaymentGateways/Controller/PaymentGatewayController.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/services/PaymentGateway/payment_service.dart';
import 'package:myott/services/setting_service.dart';

import 'Model/PackageModel.dart';


class SubscriptionController extends GetxController {
  final SettingService settingService = Get.put(SettingService(ApiService()));
  var selectedCurrency = "USD".obs; // Default USD

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

  @override
  void onClose() {
    super.onClose();
  }
}
