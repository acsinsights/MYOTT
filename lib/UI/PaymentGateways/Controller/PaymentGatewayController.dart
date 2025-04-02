import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/services/PaymentGateway/payment_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../Model/PaymentGateway.dart';

class PaymentGatewayController extends GetxController {
  final PaymentGatewayService _paymentService = PaymentGatewayService();

  var paymentGateways = <PaymentGateway>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPaymentGatewaysKeysAndSecrets();
  }



  Future<void> fetchPaymentGatewaysKeysAndSecrets() async {
    try {
      isLoading(true);
      errorMessage.value = '';

      List<PaymentGateway> gateways = await _paymentService.fetchPaymentGateways();

      print("Raw Response: ${gateways.toString()}"); // Debugging

      if (gateways.isNotEmpty) {
        paymentGateways.assignAll(gateways);
      } else {
        errorMessage.value = "No payment gateways found!";
      }
    } catch (e) {
      errorMessage.value = "Error: $e";
    } finally {
      isLoading(false);
    }
  }


}
