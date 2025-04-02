import 'dart:convert';


import 'package:myott/services/api_endpoints.dart';

import '../../UI/PaymentGateways/Model/PaymentGateway.dart';
import '../api_service.dart';

class PaymentGatewayService {
  ApiService _apiService = ApiService();



  String SecretKey = "sk_test_51R3woGCG37UV7MBErZBjcgAzaobE3U81kiJFlIiCMkUBwXJmS3Qsa92aJdI17kr9igY6epdd6PhHtLO1tU1WsNe500E2OiuT78";
  String Publishable="pk_test_51R3woGCG37UV7MBEuZDyX1QGvAqSY4yxaBUduJyQRX18ucxrozR6ezq6CPSWF0VzJ0JfmlJYeO5KAuAfTYFl8HSp00zD5Er2RF";
  Future<List<PaymentGateway>> fetchPaymentGateways() async {
    final response = await _apiService.get(APIEndpoints.paymentGateways);

    if (response?.statusCode == 200) {
      print("API Response: ${response?.data}"); // Debugging

      List<dynamic> data = jsonDecode(response?.data);

      return data.map((e) => PaymentGateway.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load payment gateways");
    }
  }

}

// class StripeService {
//   static const String secretKey = "sk_test_51R3woGCG37UV7MBErZBjcgAzaobE3U81kiJFlIiCMkUBwXJmS3Qsa92aJdI17kr9igY6epdd6PhHtLO1tU1WsNe500E2OiuT78";
//
//   static Future<void> startPayment(int amount) async {
//     try {
//       // 1️⃣ Create Payment Intent
//       String? clientSecret = await _createPaymentIntent(amount);
//       if (clientSecret == null) {
//         print("Failed to create payment intent");
//         return;
//       }
//
//       // 2️⃣ Initialize Payment Sheet
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: clientSecret,
//           merchantDisplayName: "Your App Name",
//         ),
//       );
//
//       // 3️⃣ Present Payment Sheet
//       await Stripe.instance.presentPaymentSheet();
//
//       print("Payment successful!");
//     } catch (e) {
//       print("Payment failed: $e");
//     }
//   }
//
//   // Helper Method to Create Payment Intent
//   static Future<String?> _createPaymentIntent(int amount) async {
//     try {
//       var response = await http.post(
//         Uri.parse("https://api.stripe.com/v1/payment_intents"),
//         headers: {
//           "Authorization": "Bearer $secretKey",
//           "Content-Type": "application/x-www-form-urlencoded",
//         },
//         body: {
//           "amount": (amount * 100).toString(), // Convert to cents
//           "currency": "usd",
//           "payment_method_types[]": "card",
//         },
//       );
//
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//         return data['client_secret'];
//       } else {
//         throw Exception("Failed to create payment intent: ${response.body}");
//       }
//     } catch (e) {
//       print("Error: $e");
//       return null;
//     }
//   }
// }
