import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Auth/Login/login_page.dart';
import 'package:myott/UI/Profile/screens/EditProfile/Edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/SecureStorageService.dart';
import '../../Home/Main_screen.dart';
import '../Model/otp_response_model.dart';
import '../Otp/otp_bottom_sheet.dart';
import '../Otp/otp_controller.dart';
import '../../../services/auth_service.dart';
import '../Otp/verify_otpModel.dart'; // Import Secure Storage

class AuthController extends GetxController {
  final AuthService _authService;
  final SecureStorageService _secureStorage = SecureStorageService(); // ✅ Add Secure Storage

  AuthController(this._authService);

  final OtpController otpController = Get.put(OtpController());
  TextEditingController inputController = TextEditingController();

  var isPhoneLogin = false.obs;
  var isLoading = false.obs;
  var otpSent = false.obs;
  var isVerifying = false.obs; // ✅ Fix: Define isVerifying
  var errorMessage = "".obs;
  var mobileNumber = "".obs;

  RxString emailAddress = "".obs;

  var timerValue = 60.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
  }



  Future<void> saveAuthToken(String token, String tokenType, String expiresAt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("access_token", token);
    await prefs.setString("token_type", tokenType);
    await prefs.setString("expires_at", expiresAt);  // Save expiry correctly
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

  void toggleLoginMethod() {
    isPhoneLogin.value = !isPhoneLogin.value;
    inputController.clear();
  }

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

  Future<void> sendOtp() async {
    String identifier = inputController.text.trim(); // Can be mobile or email

    if (identifier.isEmpty) {
      Get.snackbar("Error", "Please enter a valid phone number or email",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    bool isEmail = GetUtils.isEmail(identifier);

    if (!isEmail) {
      identifier = mobileNumber.value.trim();
      if (identifier.isEmpty || !identifier.startsWith("+")) {
        Get.snackbar("Error", "Please enter a valid phone number with country code",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return;
      }
    }

    isLoading.value = true;
    errorMessage.value = "";

    try {
      print("Sending OTP to: $identifier"); // ✅ Debugging log

      OtpResponseModel? response = await _authService.sendOtp(identifier: identifier);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("creating_new_account", response!.creatingNewAccount);


      if (response != null) {
        otpSent.value = true;

        if (isEmail) {
          emailAddress.value = identifier;
        } else {
          mobileNumber.value = identifier;
        }

        startOtpTimer();
        Get.bottomSheet(OtpBottomSheet());
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

  Future<void> verifyOtp() async {
    String otp = otpController.otpController.text.trim();
    String identifier = emailAddress.value.isNotEmpty ? emailAddress.value : mobileNumber.value;

    if (otp.isEmpty) {
      Get.snackbar("Error", "Please enter the OTP",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    isVerifying.value = true;

    try {
      VerifyOtpResponse response = await _authService.verifyOtp(identifier: identifier, otp: otp);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (response.token != null && response.token!.isNotEmpty) {
        await saveAuthToken(
            response.token!,
            response.tokenType ?? "Bearer",
            response.expiresAt ?? DateTime.now().toIso8601String() // ✅ Use expiresAt
        );
        bool? isNewUser = prefs.getBool("creating_new_account");
        print("✅ OTP Verified. New Account: $isNewUser");


        // if (isNewUser == true) {
        //   Get.offAll(() => EditProfileScreen());
        // } else {
        //   Get.offAll(() => MainScreen());
        // }
        Get.offAll(MainScreen());

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
      isVerifying.value = false;
    }
  }

  Future<void> resendOtp() async {
    if (timerValue.value > 0) {
      Get.snackbar(
        "Wait",
        "Please wait ${timerValue.value} seconds to resend OTP",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.yellow,
        colorText: Colors.black,
      );
      return;
    }

    String identifier = emailAddress.value.isNotEmpty
        ? emailAddress.value
        : mobileNumber.value;

    if (identifier.isEmpty) {
      Get.snackbar(
        "Error",
        "No mobile number or email found. Please enter again.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    await sendOtp(); // ✅ Resend OTP using existing method
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print("🔴 Logged out successfully");

    Get.offAll(LoginPage());
  }

  Future<bool> isTokenExpired() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? expiresAt = prefs.getString("expires_at");

    if (expiresAt == null) return true; // No expiry? Assume expired.

    DateTime expiryDate = DateTime.parse(expiresAt);
    DateTime now = DateTime.now();

    print("🕒 Token Expiry Date: $expiryDate | Current Time: $now");

    return now.isAfter(expiryDate); // True if expired
  }


  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
