import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
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
      'key': 'rzp_test_Y2wDGdLutEecD5',
      'amount': (double.parse(amount) * 100).toInt(),
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

  void startPayPalPayment(BuildContext context, double amount) async {
    var response = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaypalCheckoutView(
          sandboxMode: true, // Set to false for production
          clientId: "AWBp55P728CR8q3TnWip3rzfZpsSs2B4oJD_9BzZOUoxtaWQ83V8aCWip_OrvYNwQryegwnCVJvE7Gvn",
          secretKey: "EIkHB_hq1Dw2uAs2Y0BbQBdsG2Qr0gJlEVLtlUpJL2NepqugcuoeaS5W4d-G_ZEJvP76GiavTLZPs1Hd",

          transactions: [
            {
              "amount": {
                "total": amount.toString(),
                "currency": "USD",
              },
              "description": "Payment for Subscription",
            }
          ],
          note: "Thank you for your purchase!",
          onSuccess: (Map params) {
            print("Payment Successful: $params");
          },
          onCancel: () {
            print("Payment Cancelled");
          },
          onError: (error) {
            print("Payment Failed: $error");
          },
        ),
      ),
    );

    print("PayPal Response: $response");
  }


  // static Future<void> startFlutterwave(BuildContext context) async {
  //   final Flutterwave flutterwave = Flutterwave(
  //     context: context,
  //     publicKey: "FLWPUBK_TEST-XXXXXXXXXXXXXXXXXXXXXX", // Replace with your public key
  //     encryptionKey: "FLWSECK_TESTXXXXXXXXXXXXXXXXX", // Replace with your encryption key
  //     txRef: "TX-${DateTime.now().millisecondsSinceEpoch}",
  //     amount: "500",
  //     currency: "USD",
  //     customer: Customer(
  //       email: "user@example.com",
  //       phoneNumber: "1234567890",
  //       name: "Test User",
  //     ),
  //     paymentOptions: "card,ussd,banktransfer,mpesa",
  //     customization: Customization(title: "My OTT Payment"),
  //     isTestMode: true, // Set to false for live payments
  //   );
  //
  //   final ChargeResponse response = await flutterwave.charge();
  //
  //   if (response != null && response.status == "successful") {
  //     print("Payment successful! Transaction ID: ${response.transactionId}");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Payment successful!")),
  //     );
  //   } else {
  //     print("Payment failed or cancelled.");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Payment failed or cancelled.")),
  //     );
  //   }
  // }



}
