import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Home/Main_screen.dart';
import 'package:myott/services/ProfileService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/ProfileModel.dart';

class ProfileController extends GetxController {
  final ProfileService profileService;

  ProfileController(this.profileService);
  var profile = Rxn<Profile>(); // Observable Profile Object
  Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

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

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  void sendUserData() async {
    try {
      if (selectedImage.value == null) {
        print("No image selected!");
        return;
      }

      File imageFile = selectedImage.value!; // ✅ Ensuring it's non-null
      String email = "user@example.com";
      String name = "John Doe";
      String phone = "1234567890";

      await profileService.uploadUserData(
        imageFile: imageFile,
        email: email,
        name: name,
        phone: phone,
      );
    } catch (e) {
      print("Error uploading user data: $e");
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
