import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../UI/PaymentGateways/Model/PaymentGateway.dart';
import 'api_service.dart';

class PaymentService {
  ApiService _apiService;
  PaymentService(this._apiService);

  Future<List<PaymentGateway>> fetchPaymentGateways() async {
    final response = await _apiService.get("paymentgateway-keys?secret=06c51069-0171-4f23-bf8f-41c9cd86762d");

    if (response?.statusCode == 200) {
      print("API Response: ${response?.data}"); // Debugging

      List<dynamic> data = jsonDecode(response?.data);

      return data.map((e) => PaymentGateway.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load payment gateways");
    }
  }

}
