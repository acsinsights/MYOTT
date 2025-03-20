import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Home/Main_screen.dart';
import 'package:myott/services/ProfileService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Core/Utils/app_colors.dart';
import '../Model/ProfileModel.dart';
import '../Model/UserModel.dart';

class ProfileController extends GetxController {
  final ProfileService profileService;

  ProfileController(this.profileService);
  var profile = Rxn<Profile>(); // Observable Profile Object
  var user=Rxn<UserModel>();
  Rx<File?> selectedImage = Rx<File?>(null);
  final RxBool isLoading = false.obs; // ✅ Loading state

  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final phoneController=TextEditingController();
  @override
  void onInit() {
    fetchProfileData();
    // TODO: implement onInit
    // fetchProfile();
  }



  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      update();
    }
  }


  void sendUserData() async {
    try {
      isLoading.value = true;
      update(); // ✅ Update UI

      File? imageFile = selectedImage.value;
      String email = emailController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();

      var response = await profileService.uploadUserData(
        imageFile: imageFile ?? File(''), // ✅ Provide default empty File if null
        email: email,
        name: name,
        phone: phone,
      );

      if (response != null && response.statusCode == 200) {
        fetchProfileData(); // ✅ Refresh data after upload
        Get.snackbar("Success", "Profile updated successfully!");
      } else {
        Get.snackbar("Error", "Failed to upload data");
      }
    } catch (e) {
      print("Error uploading user data: $e");
      Get.snackbar("Error", "Something went wrong!");
    } finally {
      isLoading.value = false;
      update();
    }
  }
  void updateUserData() async {
    try {
      isLoading.value = true;
      update(); // ✅ Update UI

      File? imageFile = selectedImage.value; // Can be null
      String email = emailController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();

      if (imageFile == null) {
        Get.snackbar("Error", "Please select an image before updating your profile!",colorText: AppColors.white,backgroundColor: AppColors.primary2);
        isLoading.value = false;
        return;
      }

      var response = await profileService.uploadUserData(
        imageFile: imageFile,
        email: email,
        name: name,
        phone: phone,
      );

      if (response != null && response.statusCode == 200) {
        fetchProfileData(); // ✅ Refresh profile data
        Get.snackbar("Success", "Profile updated successfully!");
      } else {
        Get.snackbar("Error", "Failed to upload data");
      }
    } catch (e) {
      print("Error uploading user data: $e");
      Get.snackbar("Error", "Something went wrong!");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  bool validateFields() {
    if (selectedImage.value == null) {
      Get.snackbar("Error", "Please select an image before updating your profile!",
          colorText: AppColors.white, backgroundColor: AppColors.primary2);
      return false;
    }

    if (nameController.text.trim().isEmpty) {
      Get.snackbar("Error", "Name cannot be empty!",
          colorText: AppColors.white, backgroundColor: AppColors.primary2);
      return false;
    }

    if (emailController.text.trim().isEmpty) {
      Get.snackbar("Error", "Email cannot be empty!",
          colorText: AppColors.white, backgroundColor: AppColors.primary2);
      return false;
    }

    if (phoneController.text.trim().isEmpty) {
      Get.snackbar("Error", "Phone number cannot be empty!",
          colorText: AppColors.white, backgroundColor: AppColors.primary2);
      return false;
    }

    return true; // ✅ Validation passed
  }

  Future<void> fetchProfileData() async {
    try {
      final response = await profileService.getUserDetails();

      if (response != null) {
        user.value = UserModel.fromJson(response['user']);

        nameController.text = user.value!.name;
        emailController.text = user.value!.email ?? '';
        phoneController.text = user.value!.mobile ?? '';

        if (user.value!.image != null) {
          selectedImage.value = null;
        }

      } else {
        Get.snackbar("Error", "Failed to load profile data",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print("❌ Error Fetching Profile Data: $e");
      Get.snackbar("Error", "An error occurred while loading profile data.",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }






  void showDialogue() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text("Take Photo"),
              onTap: () => pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Choose from Gallery"),
              onTap: () => pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
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
