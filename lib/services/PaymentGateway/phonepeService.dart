import 'dart:convert';
import 'package:myott/services/PaymentGateway/payment_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../UI/PaymentGateways/Model/PaymentModel.dart';
import 'package:flutter/services.dart';

import 'PaymentManager.dart';

class PhonePeService implements PaymentService {
  static const MethodChannel _channel = MethodChannel('phonepe_sdk');

  @override
  Future<void> pay(PaymentData paymentData) async {
    try {
      String transactionId = "txn_${DateTime.now().millisecondsSinceEpoch}";
      int amount = paymentData.finalAmount * 100; // Convert to paise

      final result = await _channel.invokeMethod('startPhonePePayment', {
        'transactionId': transactionId,
        'amount': amount,
      });

      if (result != null && result == "SUCCESS") {
        Get.snackbar("Success", "Payment successful via PhonePe");
      } else {
        Get.snackbar("Failed", "Payment failed or cancelled");
      }
    } catch (e) {
      Get.snackbar("Error", "PhonePe payment error: ${e.toString()}");
    }
  }
}
