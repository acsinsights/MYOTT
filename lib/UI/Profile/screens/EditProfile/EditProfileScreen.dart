import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Components/custom_button.dart';
import 'package:myott/UI/Profile/Controller/ProfileController.dart';

import '../../../../services/ProfileService.dart';
import '../../../../services/api_service.dart';
import '../../../Components/custom_text_field.dart';
import 'Component/Profilepic.dart';
import 'Component/UserInfoEditField.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController(ProfileService(ApiService())));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color(0xFF000000),
        foregroundColor: Colors.white,
        title: const Text("Edit Profile"),
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Obx(() =>


                  ProfilePic(
                image: profileController.user.value?.image ??
                    'https://i.pravatar.cc/300', // ✅ Default if no image
                localImage: profileController.selectedImage.value, // ✅ Show local image if updated
                imageUploadBtnPress: () {
                  profileController.showDialogue();
                },
              )),

              const Divider(),
              Form(
                child: Column(
                  children: [
                    UserInfoEditField(
                      text: "Name",
                      child: CustomTextFieldWithNoBg(
                        controller: profileController.nameController,
                        hintText: "Enter your name",
                      ),
                    ),
                    UserInfoEditField(
                      text: "Email",
                      child: CustomTextFieldWithNoBg(
                        controller: profileController.emailController,
                        hintText: "Enter your email",
                      ),
                    ),
                    UserInfoEditField(
                      text: "Phone",
                      child: CustomTextFieldWithNoBg(
                        controller: profileController.phoneController,
                        hintText: "Enter your Phone No.",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 120,
                    child: CustomButton(
                      backgroundColor: Colors.black,
                      borderColor: Colors.white,
                      text: "Cancel",
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  SizedBox(
                    width: 160,
                    child: CustomButton(
                      text: "Save Update",
                      onPressed: () {
                        if(profileController.validateFields()){
                          profileController.sendUserData();

                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

}


