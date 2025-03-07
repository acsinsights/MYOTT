import 'package:dio/dio.dart';
import '../UI/Auth/Model/otp_response_model.dart';
import '../UI/Auth/Otp/verify_otpModel.dart';
import '../services/api_service.dart';

class AuthService {
  final ApiService _apiService;

  AuthService(this._apiService); // Dependency Injection ✅

  /// **Send OTP (Phone)**
  Future<OtpResponseModel?> sendOtp(String mobileNumber) async {
    try {
      Response? response = await _apiService.post(
        "send-otp",
        data: {"mobile": mobileNumber},
      );

      if (response != null && response.statusCode == 200) {
        return OtpResponseModel.fromJson(response.data);
      } else {
        throw Exception("Failed to send OTP");
      }
    } catch (e) {
      print("Exception in sendOtp: $e");
      return null;
    }
  }

  /// **Verify OTP (Phone)**
  Future<VerifyOtpResponse> verifyOtp(String mobileNumber, String otp) async {
    try {
      Response? response = await _apiService.post(
        "verify-otp",
        data: {"mobile": mobileNumber, "otp": otp},
      );

      if (response != null && response.statusCode == 200) {
        return VerifyOtpResponse.fromJson(response.data);
      } else {
        return VerifyOtpResponse(message: "Invalid response from server.");
      }
    } catch (e) {
      print("Exception in verifyOtp: $e");
      return VerifyOtpResponse(message: "An error occurred while verifying OTP.");
    }
  }

  /// **Send OTP (Email)**
  Future<OtpResponseModel?> sendEmailOtp(String email) async {
    try {
      Response? response = await _apiService.post(
        "send-otp", // ✅ Replace with actual email OTP endpoint
        data: {"email": email},
      );

      if (response != null && response.statusCode == 200) {
        return OtpResponseModel.fromJson(response.data);
      } else {
        throw Exception("Failed to send OTP via email");
      }
    } catch (e) {
      print("Exception in sendEmailOtp: $e");
      return null;
    }
  }

  /// **Verify OTP (Email)**
  Future<VerifyOtpResponse> verifyEmailOtp(String email, String otp) async {
    try {
      Response? response = await _apiService.post(
        "verify-otp", // ✅ Replace with actual email verification endpoint
        data: {"email": email, "otp": otp},
      );

      if (response != null && response.statusCode == 200) {
        return VerifyOtpResponse.fromJson(response.data);
      } else {
        return VerifyOtpResponse(message: "Invalid response from server.");
      }
    } catch (e) {
      print("Exception in verifyEmailOtp: $e");
      return VerifyOtpResponse(message: "An error occurred while verifying OTP.");
    }
  }
}
