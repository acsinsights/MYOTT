import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  TextEditingController otpController = TextEditingController();
  var timerValue = 30.obs;
  Timer? _timer;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  /// **Start Countdown Timer**
  void startTimer() {
    timerValue.value = 30;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerValue.value > 0) {
        timerValue.value--;
      } else {
        timer.cancel();
      }
    });
  }

  /// **Reset Timer When OTP is Resent**
  void resetTimer() {
    timerValue.value = 30;
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    super.onClose();
  }
}
