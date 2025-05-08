import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Core/Utils/app_common.dart';
import '../../PaymentGateways/PaymentSelectionScreen.dart';
import '../Setting_Controller.dart';

class WalletController extends GetxController {
  TextEditingController moneyController = TextEditingController();
  SettingController settingController = Get.find<SettingController>();
  RxInt coinsToCredit = 0.obs;

  @override
  void onInit() {
    super.onInit();

    moneyController.addListener(() {
      _calculateCoins();
    });
  }

  void _calculateCoins() {
    final input = double.tryParse(moneyController.text) ?? 0.0;

    final coinRate = settingController.settingData.value?.coins?.coins ?? 1;
    coinsToCredit.value = (input * coinRate).toInt();
  }

  void proceedToPayment() {
    final double amount = double.tryParse(moneyController.text) ?? 0.0;

    if (amount <= 0) {
      showSnackbar("Invalid Amount", "Please enter a valid amount greater than zero.",isError: true);
      return;
    }

    final String currency = "INR";

    final Data = {
      "price": amount.toInt(),
      "currency": currency,
      "paymentType": "wallet",
      "content_type": MediaType.None.name
    };

    Get.to(PaymentSelectionScreen(), arguments: Data);
    print(settingController.settingData.value?.coins?.coins);
  }

  @override
  void onClose() {
    moneyController.dispose();
    super.onClose();
  }
}
