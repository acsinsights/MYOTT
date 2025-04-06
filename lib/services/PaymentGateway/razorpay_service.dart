import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myott/Core/Utils/app_common.dart';
import 'package:myott/UI/Home/Main_screen.dart';
import 'package:myott/UI/Home/home_screen.dart';
import 'package:myott/UI/PaymentGateways/Controller/PaymentGatewayController.dart';
import 'package:myott/services/PaymentGateway/payment_Gateway_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../UI/Home/Controller/Home_controller.dart';
import '../../UI/PaymentGateways/Model/PaymentData.dart';
import 'PaymentManager.dart';

class RazorpayService implements PaymentService {
  late Razorpay _razorpay;
  late PaymentData _currentPaymentData;
  PaymentGatewayController paymentGatewayController = Get.put(PaymentGatewayController());

  RazorpayService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  }
  @override
  Future<void> pay(PaymentData paymentData) async {
       _currentPaymentData = paymentData;

    double finalAmount = paymentData.finalAmount.toDouble();

    if (paymentData.currency == "USD") {
      const double conversionRate = 83.0;
      finalAmount = finalAmount * conversionRate;
    }
    final key=paymentGatewayController.razorpayKey.value;
    var options = {
      "key": "rzp_test_Y2wDGdLutEecD5",
      "amount": (finalAmount * 100).toInt(),
      "name": "Your App",
      "currency": "INR",
      "description": "Payment for Content",
      "prefill": {
        "contact": paymentData.contact ?? "9876543210",
        "email": paymentData.email ?? "user@example.com",
      },
      "notes": {
        "paymentType": paymentData.paymentType,
        "packageId": paymentData.packageid.toString(),
        "contentId": paymentData.contentId.toString(),
        "contentType": paymentData.contentType.toString(),

      }
    };

    _razorpay.open(options);
  }

    void _handleSuccess(PaymentSuccessResponse response) async{
      print("✅ Razorpay Success: ${response.paymentId}");
      final updatedData = _currentPaymentData.copyWith(
        transactionID: response.paymentId,
        transactionStatus: "success",
      );
      try {
        await paymentGatewayController.sendPaymentToBackendWithFeedback(updatedData);
        Get.off(() => MainScreen());

      } catch (e) {
        showSnackbar("Error", "Not sended data to backend");
      }
    }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
  }

  void _handleError(PaymentFailureResponse response) {
    print("❌ Razorpay Error: ${response.message}");
  }

}