import 'package:dio/dio.dart';
import 'package:myott/services/api_service.dart';

import '../UI/Profile/Model/ProfileModel.dart';

class ProfileService {
  final ApiService _apiService;

  ProfileService(this._apiService);

  // Fetch Profile Data
  Future<ProfileModel?> getProfile() async {
    final response = await _apiService.post("profileupdate");

    if (response == null) {
      throw Exception("API request failed");
    }

    if (response.statusCode == 200) {
      final data = response.data;
      return ProfileModel.fromJson(data);
    } else {
      throw Exception("Failed to fetch profile: ${response.statusMessage}");
    }
  }

  Future<bool> createProfile(ProfileModel profile, String token) async {
    try {
      final response = await _apiService.post(
        "profileupdate", // Ensure this endpoint is correct
        data: profile.toJson(),
        token: token,
      );

      if (response?.statusCode == 200) {
        print("Profile created successfully!");
        return true;
      } else {
        print("Profile creation failed: ${response?.statusCode} - ${response?.data}");
        return false;
      }
    } catch (e) {
      print("Error creating profile: $e");
      return false;
    }
  }

  // Update Profile Data
  Future<bool> updateProfile(ProfileModel profile, String token) async {
    try {
      final response = await _apiService.post(
        "profileupdate",
        data: profile.toJson(),  // Send profile data as JSON
        token: token,
      );

      if (response?.statusCode == 200) {
        print("Profile updated successfully!");
        return true;
      } else {
        print("Profile update failed: ${response?.statusCode} - ${response?.data}");
        return false;
      }
    } catch (e) {
      print("Error updating profile: $e");
      return false;
    }
  }}
