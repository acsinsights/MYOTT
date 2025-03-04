import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Services/payment_service.dart';

class WalletController extends GetxController{
  TextEditingController moneyController=TextEditingController();
  final PaymentService paymentService = Get.put(PaymentService());

  void proceedToPayment() {

    // Convert int amount to string before passing it
    paymentService.initiatePayment(
      amount: moneyController.value.text,
      currency: "INR",
    );
  }


}
