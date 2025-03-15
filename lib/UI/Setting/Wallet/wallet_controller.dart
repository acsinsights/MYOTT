import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myott/services/api_service.dart';

import '../../../services/payment_service.dart';

class WalletController extends GetxController{
  TextEditingController moneyController=TextEditingController();
  final PaymentService paymentService = Get.put(PaymentService(ApiService()));

  void proceedToPayment() {

    // Convert int amount to string before passing it
    // paymentService.initiatePayment(
    //   amount: moneyController.value.text,
    //   currency: "INR",
    // );
  }


}
