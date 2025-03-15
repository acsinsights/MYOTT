import 'package:dio/dio.dart';
import 'package:myott/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UI/Profile/Model/ProfileModel.dart';

class ProfileService {
  final ApiService _apiService;

  ProfileService(this._apiService);


  Future<Profile?> createProfile(Profile profile) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final token = preferences.getString("access_token");
      print(token);

      final response = await _apiService.post("profileupdate", data: profile.toJson(), token: token);

      if (response != null && response.data != null && response.data is Map<String, dynamic>) {
        print("API Response: ${response.data}");

        return Profile.fromJson(response.data);

      }

      return null;
    } catch (e) {
      print("Profile creation failed: $e");
      return null;
    }
  }
}
