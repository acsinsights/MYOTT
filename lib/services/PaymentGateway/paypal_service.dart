import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../UI/PaymentGateways/Model/PaymentModel.dart';
import 'PaymentManager.dart';

class PayPalService implements PaymentService {
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
            "currency": paymentData.currency,
          },
          "description": paymentData.description ?? "Payment for Subscription",
        }
      ],
      note: "Thank you for your purchase!",
      onSuccess: (Map params) {
        print("✅ Payment Successful: $params");
      },
      onCancel: () {
        print("⚠️ Payment Cancelled");
      },
      onError: (error) {
        print("❌ Payment Failed: $error");
      },
    ));
  }
}
