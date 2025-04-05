import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myott/UI/PaymentGateways/Controller/PaymentGatewayController.dart';

import '../../Core/Utils/app_common.dart';
import '../../UI/Home/Main_screen.dart';
import '../../UI/PaymentGateways/Model/PaymentData.dart';
import 'PaymentManager.dart';

class PayPalService implements PaymentService {

  PaymentGatewayController paymentGatewayController=Get.find<PaymentGatewayController>();
  @override
  Future<void> pay(PaymentData paymentData) async {
    Get.to(() => PaypalCheckoutView(
      sandboxMode: true,
      clientId: "AWBp55P728CR8q3TnWip3rzfZpsSs2B4oJD_9BzZOUoxtaWQ83V8aCWip_OrvYNwQryegwnCVJvE7Gvn",
      secretKey: "EIkHB_hq1Dw2uAs2Y0BbQBdsG2Qr0gJlEVLtlUpJL2NepqugcuoeaS5W4d-G_ZEJvP76GiavTLZPs1Hd",

      transactions: [
        {
          "amount": {
            "total": paymentData.finalAmount.toString(),
            "currency": "USD",
          },
          "description": "Payment for Subscription",
        }
      ],
      note: "Thank you for your purchase!",
      onSuccess: (Map params) async{
        print("✅ PayPal Success: $params");

        final updatedData = paymentData.copyWith(
          transactionID: params["paymentId"] ?? "unknown_paypal_id",
          transactionStatus: "success",
        );

        try {
          await paymentGatewayController.sendPaymentToBackendWithFeedback(updatedData);
          showSnackbar("Success", "Payment Successful");

          Get.offAll(() => MainScreen());
        } catch (e) {
          showSnackbar("Error", "Failed to send data to backend");
        }      },
      onCancel: () {
        print("⚠️ Payment Cancelled");
      },
      onError: (error) {
        print("❌ Payment Failed: $error");
      },
    ));
  }
}
