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
  final RxBool isLoading = false.obs; // ✅ Loading state

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

      isLoading.value = true;
      update(); // ✅ Manually force UI update

      File imageFile = selectedImage.value!;
      String email = emailController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();

      var response = await profileService.uploadUserData(
        imageFile: imageFile,
        email: email,
        name: name,
        phone: phone,
      );

      if (response != null && response.statusCode == 200) {
        Get.offAll(() => MainScreen());
      } else {
        Get.snackbar("Error", "Failed to upload data");
      }
    } catch (e) {
      print("Error uploading user data: $e");
      Get.snackbar("Error", "Something went wrong!");
    } finally {
      isLoading.value = false;
      update(); // ✅ Manually force UI update
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
