import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myott/services/api_service.dart';

import '../../../services/PaymentGateway/payment_service.dart';

class WalletController extends GetxController{
  TextEditingController moneyController=TextEditingController();
  final PaymentGatewayService paymentService = Get.put(PaymentGatewayService());

  void proceedToPayment() {

  }


}
