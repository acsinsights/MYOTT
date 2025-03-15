import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Home/Main_screen.dart';
import 'package:myott/services/ProfileService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/ProfileModel.dart';

class ProfileController extends GetxController {
  final ProfileService profileService;

  ProfileController(this.profileService);
  var profile = Rxn<Profile>(); // Observable Profile Object

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

  Future<void> createProfile(String name, String email, String phoneNo) async {
    isLoading.value = true;
    Profile newProfile = Profile(name: name, email: email, mobile: phoneNo, id: 0);

    Profile? createdProfile = await profileService.createProfile(newProfile);
    if (createdProfile != null) {
      profile.value = createdProfile;
      Get.offAll(MainScreen());
      Get.snackbar("Success", "Profile created successfully!",colorText: CupertinoColors.white,backgroundColor: CupertinoColors.black,);
    } else {
      Get.snackbar("Error", "Failed to create profile");
    }
    isLoading.value = false;
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
