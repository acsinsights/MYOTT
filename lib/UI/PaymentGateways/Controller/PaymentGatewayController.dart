import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/services/PaymentGateway/payment_Gateway_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../Core/Utils/app_common.dart';
import '../Model/PaymentData.dart';
import '../Model/PaymentGateway.dart';
import '../paymentSuccesScreen.dart';

class PaymentGatewayController extends GetxController {
  final PaymentGatewayService _paymentService = PaymentGatewayService();

  var paymentGateways = <String, dynamic>{}.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var razorpayKey="".obs;
  var razorpaySecret="".obs;
  var paypalClientId="".obs;
  var stripeKey="".obs;
  var redirectUrl="".obs;
  var phonepeMerchantId="".obs;
  var phonepeSaltKey="".obs;


  @override
  void onInit() {
    super.onInit();
    fetchPaymentGatewaysKeysAndSecrets();
  }



  Future<void> fetchPaymentGatewaysKeysAndSecrets() async {
    try {
      isLoading(true);
      errorMessage.value = '';

      final gateway = await _paymentService.fetchPaymentGateway();

      print("Raw Response: ${gateway.toString()}"); // Debugging

      if (gateway != null) {
        paymentGateways.assignAll(gateway.toJson());

        // Now set individual keys
        razorpayKey.value = gateway.razorpayKey;
        razorpaySecret.value = gateway.razorpaySecret;
        paypalClientId.value = gateway.paypalClientId;
        stripeKey.value = gateway.stripeKey;
        phonepeMerchantId.value=gateway.phonepeMerchantId;
        redirectUrl.value=gateway.phonepeRedirectUrl;
        phonepeSaltKey.value=gateway.phonepeSaltKey;


        // Add more as needed...
      } else {
        errorMessage.value = "No payment gateways found!";
      }
    } catch (e) {
      errorMessage.value = "Error: $e";
    } finally {
      isLoading(false);
    }
  }

  Future<void> sendPaymentToBackendWithFeedback(PaymentData data) async {
    try {
      showLoading();
      await _paymentService.sendPaymentDataToBackend(data);
      Get.off(() => PaymentSuccessScreen(transactionId: data.transactionID ?? ""));
dismissLoading();
      showSnackbar("Success", "Payment successfully");
    } catch (e) {
      dismissLoading();
      showSnackbar("Error", "Failed to send payment data", isError: true);
    }
  }


}
