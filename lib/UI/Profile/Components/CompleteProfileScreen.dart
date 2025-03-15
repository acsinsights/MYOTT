import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/services/api_service.dart';

import '../../../services/ProfileService.dart';
import '../Controller/ProfileController.dart';

class CompleteProfileScreen extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController(ProfileService(ApiService())));

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Name", nameController),
            SizedBox(height: 12.h),
            _buildTextField("Email", emailController),
            SizedBox(height: 12.h),
            _buildTextField("Phone Number", phoneController),
            SizedBox(height: 24.h),
            Obx(() => ElevatedButton(
              onPressed: profileController.isLoading.value
                  ? null
                  : () {
                profileController.createProfile(
                  nameController.text,
                  emailController.text,
                  phoneController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                minimumSize: Size(double.infinity, 50.h),
              ),
              child: profileController.isLoading.value
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Submit", style: TextStyle(fontSize: 16.sp)),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white54),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
