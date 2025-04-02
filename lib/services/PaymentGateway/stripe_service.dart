import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart'as http;
import '../../UI/PaymentGateways/Model/PaymentModel.dart';
import 'PaymentManager.dart';

class StripeService implements PaymentService {
  static const String secretKey = "sk_test_51R3woGCG37UV7MBErZBjcgAzaobE3U81kiJFlIiCMkUBwXJmS3Qsa92aJdI17kr9igY6epdd6PhHtLO1tU1WsNe500E2OiuT78";
  @override
  Future<void> pay(PaymentData paymentData) async {
    try {
      String? clientSecret = await _createPaymentIntent(paymentData.price);
      if (clientSecret == null) {
        print("❌ Failed to create payment intent");
        return;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(

          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "Your App Name",
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      print("✅ Stripe Payment Successful");

    } catch (e) {
      print("❌ Stripe Payment Failed: $e");
    }

  }

  static Future<String?> _createPaymentIntent(int amount) async {
    try {
      int amountInCents = (amount * 100).toInt();

      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          "Authorization": "Bearer $secretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          "amount": amountInCents.toString(),
          "currency": "usd",
          "payment_method_types[]": "card",
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['client_secret'];
      } else {
        throw Exception("❌ Failed to create payment intent: ${response.body}");
      }
    } catch (e) {
      print("❌ Error in Stripe API: $e");
      return null;
    }
  }
}
