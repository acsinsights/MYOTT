import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import '../../UI/PaymentGateways/Model/PaymentData.dart';
import 'PaymentManager.dart';

class PhonePeService implements PaymentService {
  Object? result;
  final String environmentValue = 'SANDBOX';
  final String appId = "ENTER_YOUR_APP_ID";
  final String callbackUrl = "https://yourdomain.com/payment/callback";
  final String merchantId = "MERCHANTUAT";
  final bool enableLog = true;
  final String packageName = "com.mediacity.nexthour";
  final String mobileNumber = "ENTER_MERCHANT_MOBILE_NO"; // Replace this

  void phonepeInit() {
    PhonePePaymentSdk.init(environmentValue, appId, merchantId, enableLog).then((val) {
      result = 'PhonePe SDK Initialized - $val';
    }).catchError((error) {
      handleError(error);
    });
  }

  @override
  Future<void> pay(PaymentData paymentData) async {
    try {
      phonepeInit();

      final String merchantTransactionId = "MT${_getRandomNumber()}";
      final String merchantUserId = "MU${_getRandomNumber()}";

      final Map<String, dynamic> requestData = {
        "merchantId": merchantId,
        "merchantTransactionId": merchantTransactionId,
        "merchantUserId": merchantUserId,
        "amount": (paymentData.price * 100).toInt(),
        "callbackUrl": callbackUrl,
        "mobileNumber": mobileNumber,
        "paymentInstrument": {"type": "PAY_PAGE"},
      };

      final String jsonString = jsonEncode(requestData);
      const String apiEndPoint = "/pg/v1/pay";
      const String saltIndex = "1";
      final String saltKey = "";

      final String base64Body = jsonString.toBase64;
      final String checksum = "${_generateSha256Hash(base64Body + apiEndPoint + saltKey)}###$saltIndex";

      debugPrint("Base64 Body: $base64Body");
      debugPrint("Checksum: $checksum");
      final response = await PhonePePaymentSdk.startTransaction(
        base64Body,
        packageName, // this is your appSchema
      );

      if (response != null) {
        String status = response['status'].toString();
        String? error = response['error']?.toString();
        if (status == 'SUCCESS') {
          result = "Flow Completed - Status: Success!";
          Get.snackbar("Payment", "Transaction successful");
          // TODO: Call your API to mark payment success, pass `paymentData`
        } else {
          result = "Flow Completed - Status: $status and Error: $error";
          Get.snackbar("Payment Failed", "$status: $error");
        }
      } else {
        result = "Flow Incomplete";
        Get.snackbar("Payment", "Payment flow incomplete.");
      }
    } catch (e) {
      handleError(e);
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

  void handleError(error) {
    debugPrint("PhonePe Error: $error");
    if (error is Exception) {
      result = error.toString();
    } else {
      result = {"error": error};
    }
    Get.snackbar("PhonePe Error", result.toString());
  }
}

extension EncodingExtensions on String {
  String get toBase64 => base64.encode(toUtf8);
  List<int> get toUtf8 => utf8.encode(this);
  String get toSha256 => sha256.convert(toUtf8).toString();
}
