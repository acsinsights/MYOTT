import 'dart:io';

import 'package:dio/dio.dart';
import 'package:myott/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UI/Profile/Model/ProfileModel.dart';

class ProfileService {
  final ApiService _apiService;

  ProfileService(this._apiService);

  Future<Response?> uploadUserData({
    required File imageFile,
    required String email,
    required String name,
    required String phone,
  }) async {
    FormData formData = FormData.fromMap({
      'email': email,
      'name': name,
      'phone': phone,
      'image': await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last),
    });
    SharedPreferences prefs=await SharedPreferences.getInstance();
    final token= prefs.getString("access_token");

    return await _apiService.postWithImage(
      "/upload-user-data",
      data: formData,
      token: token,
    );
  }




}
