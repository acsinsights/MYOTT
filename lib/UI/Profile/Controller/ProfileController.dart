import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_common.dart';
import 'package:myott/UI/Home/Main_screen.dart';
import 'package:myott/services/ProfileService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Core/Utils/app_colors.dart';
import '../Model/ProfileModel.dart';
import '../Model/UserModel.dart';

class ProfileController extends GetxController {
  final ProfileService profileService=ProfileService();

  var user=Rxn<UserModel>();
  Rx<File?> selectedImage = Rx<File?>(null);
  final RxBool isLoading = false.obs;

  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final phoneController=TextEditingController();


  @override
  void onInit() {
    fetchProfileData();
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      update();
      Get.back(canPop: true);
    }
  }


  void sendUserData() async {
    try {
      isLoading.value = true;
      update(); // ✅ Update UI

      File? imageFile = selectedImage.value;
      String email = emailController.text.trim();
      String name = nameController.text.trim();
 String phone = phoneController.text.trim().toString();


      var response = await profileService.uploadUserData(
        imageFile: imageFile ?? File(''),
        email: email,
        name: name,
        phone: phone,
      );

      if (response != null && response.statusCode == 200) {
        await fetchProfileData();
        showSnackbar("Success", "Profile updated successfully!",isError: false);
      } else {
        showSnackbar("Error", "Failed to upload data",isError: true);

      }
    } catch (e) {
      print("Error uploading user data: $e");
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
        showSnackbar("Error", "Please select an image before updating your profile!",isError: true);

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
        showSnackbar("Success", "Profile updated successfully!",isError: false);
      } else {

        showSnackbar("Error", "Failed to upload data",isError: true);
      }
    } catch (e) {
      print("Error uploading user data: $e");
      // Get.snackbar("Error", "Something went wrong!");
    } finally {
      isLoading.value = false;
      update();
    }
  }

  bool validateFields() {
    if (selectedImage.value == null) {
      showSnackbar("Error", "Please select an image before updating your profile!",isError: true);


      return false;
    }

    if (nameController.text.trim().isEmpty) {
      showSnackbar("Error", "Name cannot be empty!!",isError: true);


      return false;
    }

    if (emailController.text.trim().isEmpty) {
      showSnackbar("Error", "Email cannot be empty!",isError: true);


      return false;
    }

    if (phoneController.text.trim().isEmpty) {
      showSnackbar("Error", "Phone number cannot be empty!",isError: true);


      return false;
    }

    return true; // ✅ Validation passed
  }


  Future<void> fetchProfileData() async {
    try {
      isLoading(true);
      final response = await profileService.getUserDetails();


      if (response != null) {
        user.value = UserModel.fromJson(response['user']);

        nameController.text = user.value!.name;
        emailController.text = user.value!.email ?? '';
        phoneController.text = user.value!.mobile ?? '';

        if (user.value!.image != null) {
          selectedImage.value = null;
        }
        isLoading(false);

      } else {
        showSnackbar("Failed", "Failed to load profile data",isError: true);

      }
    } catch (e) {
      isLoading(false);
      print("❌ Error Fetching Profile Data: $e");
      // Get.snackbar("Error", "An error occurred while loading profile data.",
      //     backgroundColor: Colors.red, colorText: Colors.white);
    }
  }




  Future<void> refreshUser() async {
    try {
      final response = await profileService.getUserDetails();

      if (response != null && response['user'] != null) {
        user.value = UserModel.fromJson(response['user']);
        update();
      } else {
        showSnackbar("Error", "Unable to refresh user data",isError: true);


      }
    } catch (e) {
      print("❌ Error refreshing user data: $e");
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

}
