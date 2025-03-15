import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/services/payment_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../Model/PaymentGateway.dart';

class PaymentGatewayController extends GetxController {
  final PaymentService _paymentService = PaymentService(ApiService());

  var paymentGateways = <PaymentGateway>[].obs; // Store fetched data
  var isLoading = false.obs; // Handle loading state
  var errorMessage = ''.obs; // Store error message if any

  @override
  void onInit() {
    super.onInit();
    fetchPaymentGatewaysKeysAndSecrets(); // Automatically fetch on controller init
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

  late Razorpay _razorpay;

  PaymentGatewayController() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  void initiatePayment({required String amount, required String currency}) {
    var options = {
      'key': 'rzp_test_Y2wDGdLutEecD5', // Use Test Key only
      'amount': (double.parse(amount) * 100).toInt(), // Convert ₹ to paise
      'currency': currency,
      'name': 'My OTT Platform',
      'description': 'Subscription Payment',
      'prefill': {'email': 'user@example.com', 'contact': '9876543210'},
      'theme': {'color': '#FF0000'}
    };

    try {
      Razorpay _razorpay = Razorpay();
      _razorpay.open(options);
    } catch (e) {
      print("Payment Error: $e");
      Get.snackbar("Payment Failed", "Something went wrong",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }


  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar("Success", "Payment ID: ${response.paymentId}",
        backgroundColor: Colors.green, colorText: Colors.white);
    print("Payment Success: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error Code: ${response.code}");
    print("Payment Error Message: ${response.message}");

    Get.snackbar("Error", "Payment failed: ${response.message}",
        backgroundColor: Colors.red, colorText: Colors.white);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("Wallet", "External Wallet Selected: ${response.walletName}");
    print("External Wallet: ${response.walletName}");
  }
  void dispose() {
    _razorpay.clear();
  }

}
