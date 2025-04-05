import 'dart:convert';


import 'package:myott/UI/PaymentGateways/Model/PaymentData.dart';
import 'package:myott/services/api_endpoints.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../UI/PaymentGateways/Model/PaymentGateway.dart';
import '../api_service.dart';

class PaymentGatewayService {
  ApiService _apiService = ApiService();



  String SecretKey = "sk_test_51R3woGCG37UV7MBErZBjcgAzaobE3U81kiJFlIiCMkUBwXJmS3Qsa92aJdI17kr9igY6epdd6PhHtLO1tU1WsNe500E2OiuT78";
  String Publishable="pk_test_51R3woGCG37UV7MBEuZDyX1QGvAqSY4yxaBUduJyQRX18ucxrozR6ezq6CPSWF0VzJ0JfmlJYeO5KAuAfTYFl8HSp00zD5Er2RF";
  Future<PaymentGateway> fetchPaymentGateway() async {
    final response = await _apiService.get(APIEndpoints.paymentGateways);

    if (response?.statusCode == 200) {
      print("API Response: ${response?.data}"); // Debugging

      Map<String, dynamic> data = jsonDecode(response!.data);
      return PaymentGateway.fromJson(data);
    } else {
      throw Exception("Failed to load payment gateway");
    }
  }

  Future<void> sendPaymentDataToBackend(PaymentData paymentData) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    final token=sharedPreferences.getString("access_token");
    try {
      String url = "";

      switch (paymentData.paymentType) {
        case "subscription":
          url = APIEndpoints.createOrderPackage;
          break;
        case "coin":
          url = APIEndpoints.createOrderCoin;
          break;
        case "ppv":
          url = APIEndpoints.createOrderPPV;
          break;
        default:
          throw Exception("Invalid payment type");
      }

      final response = await _apiService.post(url,token: token, data: paymentData.toJson());

      if (response!.statusCode == 200 || response.statusCode == 201) {
        print("✅ Payment Data Sent Successfully");
      } else {
        print("❌ Failed to send payment data: ${response.data}");
        throw Exception("Server Error");
      }
    } catch (e) {
      print("❌ Exception while sending payment data: $e");
      rethrow;
    }
  }


// Future<void> sendPaymentData(Object req) async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   final String? token = preferences.getString("access_token");
  //
  //   if (token == null) {
  //     throw Exception("Access token not found.");
  //   }
  //
  //   await _apiService.post(
  //     APIEndpoints.creatOrderPackage,
  //     token: token,
  //     data: paymentData.toJson(), // Make sure PaymentData has a toJson() method
  //   );
  // }




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
