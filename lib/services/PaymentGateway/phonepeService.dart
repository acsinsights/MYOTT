import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:myott/Core/Utils/app_common.dart';
import 'package:myott/UI/PaymentGateways/Controller/PaymentGatewayController.dart';
import 'package:myott/UI/PaymentGateways/Model/PaymentData.dart';
import 'PaymentManager.dart';

class PhonePeService implements PaymentService {
  late PaymentData _currentPaymentData;
  String? _merchantTransactionId;
  PaymentGatewayController paymentGatewayController = Get.put(PaymentGatewayController());

  Object? result;
  final String environmentValue = 'UAT';
  final String appId = "ENTER_YOUR_APP_ID";
  final String callbackUrl = "https://yourdomain.com/payment/callback";
  bool isInitialized = false;
  final bool enableLog = true;
  final String packageName = "com.mediacity.nexthour";

  PhonePeService() {
    phonepeInit();
  }

  void phonepeInit() {
    final merchantId = paymentGatewayController.phonepeMerchantId.value;
    final flowId = "FLOW_${_getRandomNumber().substring(0, 8)}"; // Generate a shorter flowId

    PhonePePaymentSdk.init(environmentValue, merchantId, flowId, enableLog).then((val) {
      result = 'PhonePe SDK Initialized - $val';
      isInitialized = true;
      debugPrint('PhonePe SDK Initialized: $val');
    }).catchError((error) {
      handleError(error);
    });
  }

  @override
  Future<void> pay(PaymentData paymentData) async {
    try {
      _currentPaymentData = paymentData;

      double finalAmount = paymentData.finalAmount.toDouble();

      if (paymentData.currency == "USD") {
        const double conversionRate = 83.0;
        finalAmount = finalAmount * conversionRate;
      }

      _merchantTransactionId = "MT${_getRandomNumber()}";
      final String merchantUserId = "MU${_getRandomNumber()}";
      final String merchantId = paymentGatewayController.phonepeMerchantId.value;
      final String saltKey = paymentGatewayController.phonepeSaltKey.value;
      final String saltIndex = "1";

      final Map<String, dynamic> requestData = {
        "merchantId": merchantId,
        "merchantTransactionId": _merchantTransactionId,
        "merchantUserId": merchantUserId,
        "amount": (finalAmount * 100).toInt(),
        "callbackUrl": callbackUrl,
        "mobileNumber": paymentData.contact ?? "9876543210",
        "paymentInstrument": {"type": "PAY_PAGE"},
      };

      // Store merchant transaction ID for verification later
      _currentPaymentData = paymentData.copyWith(
        transactionID: _merchantTransactionId,
      );

      final String jsonString = jsonEncode(requestData);
      const String apiEndPoint = "/pg/v1/pay";

      final String base64Body = base64.encode(utf8.encode(jsonString));
      final String checksum = "${_generateSha256Hash(base64Body + apiEndPoint + saltKey)}###$saltIndex";

      debugPrint("Base64 Body: $base64Body");
      debugPrint("Checksum: $checksum");

      final response = await PhonePePaymentSdk.startTransaction(
          base64Body,
          packageName  // This is your appSchema
      );

      _handlePhonePeResponse(response);
    } catch (e) {
      handleError(e);
    }
  }

  void _handlePhonePeResponse(Map<dynamic, dynamic>? response) async {
    if (response != null) {
      String status = response['status'].toString();
      String? error = response['error']?.toString();

      if (status == 'SUCCESS') {
        print("✅ PhonePe Success with Merchant Transaction ID: ${_currentPaymentData.transactionID}");

        final updatedData = _currentPaymentData.copyWith(
          transactionStatus: "success",
        );

        try {
          await paymentGatewayController.sendPaymentToBackendWithFeedback(updatedData);
          // Get.to(() => PaymentSuccessScreen(transactionId: _currentPaymentData.transactionID));
        } catch (e) {
          showSnackbar("Error", "Not sent data to backend");
          print("Backend API Error: $e");
        }
      } else {
        print("❌ PhonePe Error: Status: $status, Error: $error");
        showSnackbar("Payment Failed", "$status: $error");
      }
    } else {
      print("❌ PhonePe Error: No response");
      showSnackbar("Payment", "Payment flow incomplete.");
    }
  }

  String _generateSha256Hash(String input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  String _getRandomNumber() {
    Random random = Random();
    return List.generate(15, (index) => random.nextInt(10)).join();
  }

  void handleError(dynamic error) {
    debugPrint("PhonePe Error: $error");
    print("❌ PhonePe Error: $error");
    showSnackbar("PhonePe Error", error.toString());
  }
}

extension EncodingExtensions on String {
  String get toBase64 => base64.encode(utf8.encode(this));
  List<int> get toUtf8 => utf8.encode(this);
  String get toSha256 => sha256.convert(utf8.encode(this)).toString();
}