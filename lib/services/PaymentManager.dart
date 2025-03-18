import 'dart:convert';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:get/get.dart';

enum PaymentMethod { Razorpay, Stripe, PayPal }

class PaymentManager {
  final Map<PaymentMethod, PaymentService> _paymentServices = {
    PaymentMethod.Razorpay: RazorpayService(),
    PaymentMethod.Stripe: StripeService(),
    PaymentMethod.PayPal: PayPalService(),
  };

  /// **Start Payment**
  Future<void> startPayment(PaymentMethod method, double amount) async {
    PaymentService? service = _paymentServices[method];
    if (service != null) {
      await service.pay(amount);
    } else {
      Get.snackbar("Error", "Invalid Payment Method Selected");
    }
  }
}

abstract class PaymentService {
  Future<void> pay(double amount);
}

class RazorpayService implements PaymentService {
  late Razorpay _razorpay;

  RazorpayService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
  }

  @override
  Future<void> pay(double amount) async {
    var options = {
      "key": "rzp_test_Y2wDGdLutEecD5", // Replace with actual key
      "amount": (amount * 100).toInt(), // Amount in paise
      "name": "Your App",
      "description": "Payment for Content",
      "prefill": {"contact": "9876543210", "email": "user@example.com"}
    };
    _razorpay.open(options);
  }

  void _handleSuccess(PaymentSuccessResponse response) {
    print("✅ Razorpay Success: ${response.paymentId}");
  }

  void _handleError(PaymentFailureResponse response) {
    print("❌ Razorpay Error: ${response.message}");
  }
}

class StripeService implements PaymentService {
  static const String secretKey = "sk_test_51R3woGCG37UV7MBErZBjcgAzaobE3U81kiJFlIiCMkUBwXJmS3Qsa92aJdI17kr9igY6epdd6PhHtLO1tU1WsNe500E2OiuT78";

  @override
  Future<void> pay(double amount) async {
    try {
      String? clientSecret = await _createPaymentIntent(amount);
      if (clientSecret == null) {
        print("❌ Failed to create payment intent");
        return;
      }

      // 2️⃣ Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "Your App Name",
        ),
      );

      // 3️⃣ Present Payment Sheet
      await Stripe.instance.presentPaymentSheet();
      print("✅ Stripe Payment Successful");

    } catch (e) {
      print("❌ Stripe Payment Failed: $e");
    }
  }

  static Future<String?> _createPaymentIntent(double amount) async {
    try {
      // 🔹 Convert amount to cents and ensure it's an integer
      int amountInCents = (amount * 100).toInt();

      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          "Authorization": "Bearer $secretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          "amount": amountInCents.toString(), // ✅ Now it's an integer
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
class PayPalService implements PaymentService {
  @override
  Future<void> pay(double amount) async {
    Get.to(() => PaypalCheckoutView(
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

    ));
  }
}
