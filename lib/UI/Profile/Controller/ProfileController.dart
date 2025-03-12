import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myott/services/ProfileService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/ProfileModel.dart';

class ProfileController extends GetxController {
  final ProfileService _profileService;

  ProfileController(this._profileService);
  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final phoneController=TextEditingController();
  final addressController=TextEditingController();
  final oldPasswordController=TextEditingController();
  final newPasswordController=TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    // fetchProfile();
  }

 
  var isLoading = false.obs;



  Future<void> saveProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("access_token");

    if (token == null) {
      Get.snackbar("Error", "Token not found. Please log in again.");
      return;
    }

    ProfileModel profileData = ProfileModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      mobile: phoneController.text.trim(),
    );

    bool success = await _profileService.createProfile(profileData, token);

    if (success) {
      Get.snackbar("Success", "Profile created successfully",
        backgroundColor: CupertinoColors.black,
        colorText: CupertinoColors.white,
      );
    } else {
      Get.snackbar("Error", "Failed to create profile");
    }
  }

  // // Fetch Profile
  // Future<void> fetchProfile() async {
  //   try {
  //     isLoading.value = true;
  //     final fetchedProfile = await _profileService.getProfile();
  //     if (fetchedProfile != null) {
  //       profile.value = fetchedProfile;
  //     }
  //   } catch (e) {
  //     print("Error fetching profile: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //
  // // Update Profile
  // Future<void> updateProfile() async {
  //   try {
  //     isLoading.value = true;
  //     SharedPreferences prefs=await SharedPreferences.getInstance();
  //     final token= prefs.getString("access_token");
  //     bool success = await _profileService.updateProfile(profile.value,token!);
  //     if (success) {
  //       print("Profile updated successfully");
  //     } else {
  //       print("Profile update failed");
  //     }
  //   } catch (e) {
  //     print("Error updating profile: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
