import 'package:dio/dio.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import '../UI/Auth/Model/otp_response_model.dart';
import '../UI/Auth/Otp/verify_otpModel.dart';
import '../services/api_service.dart';

class AuthService {
  final ApiService _apiService;
  final ApiService apiService = ApiService();

  AuthService(this._apiService);

  Future<OtpResponseModel?> sendOtp({required String identifier}) async {
    try {
      bool isEmail = GetUtils.isEmail(identifier);

      Response? response = await _apiService.post(
        "send-otp",
        data: isEmail ? {"email": identifier} : {"mobile": identifier},
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



  Future<VerifyOtpResponse> verifyOtp({required String identifier, required String otp}) async {
    try {
      // Identify if it's an email or mobile based on the format
      bool isEmail = GetUtils.isEmail(identifier);

      Response? response = await _apiService.post(
        "verify-otp",
        data: isEmail ? {"email": identifier, "otp": otp} : {"mobile": identifier, "otp": otp},
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

}
