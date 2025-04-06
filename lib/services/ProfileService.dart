import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:myott/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UI/Profile/Model/ProfileModel.dart';

class ProfileService {
  final ApiService _apiService=ApiService();


  Future<Response?> uploadUserData({
    required File imageFile,
    required String email,
    required String name,
    required String phone,
  }) async {
    FormData formData = FormData.fromMap({
      'email': email,
      'name': name,
      'mobile': phone,
      'image': await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
    });
    SharedPreferences prefs=await SharedPreferences.getInstance();
    final token= prefs.getString("access_token");

    return await _apiService.postWithImage(
      "profileupdate",
      data: formData,
      token: token,
    );
  }

  Future<Map<String, dynamic>?> getUserDetails() async {
    try {
      final response = await _apiService.get("user-data");

      if (response?.statusCode == 200) {
        // Ensure response.body is properly decoded
        if (response?.data is Map<String, dynamic>) {
          return response?.data;
        } else {
          return jsonDecode(response?.data);
        }
      } else {
        print("❌ Error: ${response?.statusCode} - ${response?.data}");
        return null;
      }
    } catch (e) {
      print("❌ Error Fetching User Details: $e");
      return null;
    }
  }



}
