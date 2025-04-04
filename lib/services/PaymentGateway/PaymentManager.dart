  import 'dart:convert';

  import 'package:myott/Core/Utils/app_colors.dart';
  import 'package:myott/services/PaymentGateway/paypal_service.dart';
import 'package:myott/services/PaymentGateway/phonepeService.dart';
  import 'package:myott/services/PaymentGateway/razorpay_service.dart';
  import 'package:myott/services/PaymentGateway/stripe_service.dart';
  import 'package:razorpay_flutter/razorpay_flutter.dart';
  import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
  import 'package:get/get.dart';
  import 'package:http/http.dart' as http;
  import 'package:flutter_stripe/flutter_stripe.dart';

  import '../../UI/PaymentGateways/Model/PaymentData.dart';

  enum PaymentMethod { Razorpay, Stripe, PayPal,PhonePe }
  abstract class PaymentService {
    Future<void> pay(PaymentData paymentData);
  }
  class PaymentManager {
    final Map<PaymentMethod, PaymentService> _paymentServices = {
      PaymentMethod.Razorpay: RazorpayService(),
      PaymentMethod.Stripe: StripeService(),
      PaymentMethod.PayPal: PayPalService(),
      PaymentMethod.PhonePe: PhonePeService()

    };

    Future<void> startPayment(PaymentData paymentData) async {
      PaymentService? service = _paymentServices[paymentData.method];

      if (service != null) {
        int finalAmount = paymentData.finalAmount;

        if (finalAmount <= 0) {
          Get.snackbar("Error", "Invalid payment amount.");
          return;
        }

        await service.pay(paymentData);
      } else {
        Get.snackbar("Error", "Invalid Payment Method Selected");
      }
    }






  }








