import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  late Razorpay _razorpay;

  PaymentService() {
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
