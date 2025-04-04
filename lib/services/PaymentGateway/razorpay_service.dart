import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../UI/PaymentGateways/Model/PaymentData.dart';
import 'PaymentManager.dart';

class RazorpayService implements PaymentService {
  late Razorpay _razorpay;

  RazorpayService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  }
  @override
  Future<void> pay(PaymentData paymentData) async {
    double conversionRate = 83.0;
    double finalAmount = paymentData.finalAmount.toDouble();
    finalAmount = finalAmount * conversionRate;

    ///fetch key form the paymentGatewayCOmtrller
    ///      PaymentKeys keys=await apiService.fetchPayementApi();
    //       var key=keys.keyId.toString();

    var options = {
      "key": "rzp_test_Y2wDGdLutEecD5",
      "amount": (finalAmount * 100).toInt(),
      "name": "Your App",
      "currency": "INR",
      "description": paymentData.description ?? "Payment for Content",
      "prefill": {
        "contact": paymentData.contact ?? "9876543210",
        "email": paymentData.email ?? "user@example.com",
      },
      "notes":{

      }
    };

    _razorpay.open(options);

  }

  void _handleSuccess(PaymentSuccessResponse response) {
    print("✅ Razorpay Success: ${response.paymentId}");


  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
  }

  void _handleError(PaymentFailureResponse response) {
    print("❌ Razorpay Error: ${response.message}");
  }
}