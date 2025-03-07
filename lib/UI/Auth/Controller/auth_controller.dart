import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Services/SecureStorageService.dart';
import '../../Home/Main_screen.dart';
import '../Model/otp_response_model.dart';
import '../Otp/otp_bottom_sheet.dart';
import '../Otp/otp_controller.dart';
import '../../../Services/auth_service.dart';
import '../Otp/verify_otpModel.dart'; // Import Secure Storage

class AuthController extends GetxController {
  final AuthService _authService;
  final SecureStorageService _secureStorage = SecureStorageService(); // ✅ Add Secure Storage

  AuthController(this._authService);

  final OtpController otpController = Get.put(OtpController());

  var isPhoneLogin = false.obs;
  TextEditingController inputController = TextEditingController();
  var isLoading = false.obs;
  var otpSent = false.obs;
  var isVerifying = false.obs; // ✅ Fix: Define isVerifying
  var errorMessage = "".obs;
  var mobileNumber = "".obs;
  RxString emailAddress = "".obs;

  var token = "".obs;
  var otp = "".obs; // Store entered OTP
  var timerValue = 60.obs;
  Timer? _timer;


  Future<void> saveAuthToken(String token, String tokenType, int expiresIn) async {
    await _secureStorage.write(key: "accessToken", value: token);
    await _secureStorage.write(key: "tokenType", value: tokenType);
    await _secureStorage.write(key: "expiresIn", value: expiresIn.toString());
  }

  Future<String?> getAuthToken() async {
    return await _secureStorage.read(key: "accessToken");
  }

  Future<void> clearAllSecureStorage() async {
    List<String> keys = ["accessToken", "tokenType", "expiresIn", "refreshToken"];

    for (String key in keys) {
      await _secureStorage.delete(key: key);
    }
  }



  /// **Toggle Login Mode**
  void toggleLoginMethod() {
    isPhoneLogin.value = !isPhoneLogin.value;
    inputController.clear();
  }

  /// **Start OTP Timer**
  void startOtpTimer() {
    timerValue.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerValue.value > 0) {
        timerValue.value--;
      } else {
        timer.cancel();
      }
    });
  }

  /// **Send OTP**
  Future<void> sendOtp(String mobile) async {
    if (mobile.isEmpty) {
      Get.snackbar("Error", "Please enter a valid phone number",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.black,
          colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    errorMessage.value = "";

    try {
      OtpResponseModel? response = await _authService.sendOtp(mobile);

      if (response != null) {
        otpSent.value = true;
        mobileNumber.value = mobile; // ✅ Save mobile number for verification
        startOtpTimer();
        Get.bottomSheet(OtpBottomSheet()); // Open OTP Bottom Sheet
      } else {
        errorMessage.value = "Failed to send OTP. Try again.";
        Get.snackbar("Error", errorMessage.value,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      errorMessage.value = "Error: ${e.toString()}";
      Get.snackbar("Error", errorMessage.value,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> sendEmailOtp(String email) async {
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Get.snackbar("Error", "Please enter a valid email address",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.black,
          colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    errorMessage.value = "";
    emailAddress.value = email; // ✅ Update email variable

    try {
      OtpResponseModel? response = await _authService.sendEmailOtp(email);

      if (response != null) {
        otpSent.value = true;
        startOtpTimer();
        Get.bottomSheet(OtpBottomSheet()); // ✅ Open OTP Bottom Sheet
      } else {
        errorMessage.value = "Failed to send OTP. Try again.";
        Get.snackbar("Error", errorMessage.value,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      errorMessage.value = "Error: ${e.toString()}";
      Get.snackbar("Error", errorMessage.value,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
  /// **Verify OTP**
  Future<void> verifyOtp() async {
    String otp = otpController.otpController.text.trim();
    String input = mobileNumber.value; // Could be email or phone

    if (otp.isEmpty) {
      Get.snackbar("Error", "Please enter the OTP",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    isVerifying.value = true; // ✅ Show loading indicator

    try {
      VerifyOtpResponse response;

      if (isPhoneLogin.value) {
        // ✅ Handle Phone OTP Verification
        response = await _authService.verifyOtp(input, otp);
      } else {
        // ✅ Handle Email OTP Verification
        response = await _authService.verifyEmailOtp(input, otp);
      }

      if (response.token != null && response.token!.isNotEmpty) {
        // ✅ Store token securely
        await _secureStorage.write(key: "accessToken", value: response.token!);
        await _secureStorage.write(key: "tokenType", value: response.tokenType ?? "Bearer");
        await _secureStorage.write(key: "expiresIn", value: response.expiresIn?.toString() ?? "0");

        Get.offAll(() => MainScreen());

        Get.snackbar("Success", response.message,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        Get.snackbar("Error", response.message.isNotEmpty ? response.message : "Invalid OTP",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to verify OTP. Please try again.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isVerifying.value = false; // ✅ Hide loading indicator
    }
  }

  /// **Resend OTP**
  Future<void> resendOtp() async {
    if (timerValue.value > 0) {
      Get.snackbar("Wait", "Please wait ${timerValue.value} seconds to resend OTP",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.yellow,
          colorText: Colors.black);
      return;
    }

    await sendOtp(mobileNumber.value);
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
