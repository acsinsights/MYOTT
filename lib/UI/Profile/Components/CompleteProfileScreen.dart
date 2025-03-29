import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myott/UI/Components/custom_button.dart';
import 'package:myott/UI/Home/Main_screen.dart';
import 'package:myott/services/api_service.dart';
import '../../../services/ProfileService.dart';
import '../Controller/ProfileController.dart';

class CompleteProfileScreen extends StatelessWidget {
  final ProfileController profileController =
      Get.put(ProfileController(ProfileService(ApiService())));


  final RxString emailError = "".obs;
  final RxString phoneError = "".obs;
  final RxString nameError = "".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complete Profile",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildProfileImage(),
              const SizedBox(height: 20),
              Obx(() => _buildTextField("Name", profileController.nameController,
                  errorText: nameError.value)),
              SizedBox(height: 12.h),
              Obx(() => _buildTextField("Email", profileController.emailController,
                  errorText: emailError.value)),
              SizedBox(height: 12.h),
              Obx(() => _buildTextField("Phone Number", profileController.phoneController,
                  errorText: phoneError.value)),
              SizedBox(height: 24.h),
              Obx(() {
                return profileController.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white) // ✅ Loading spinner
                    : CustomButton(
                  text: "Submit",
                  onPressed: () async {
                    if (_validateInputs()) {
                      if (profileController.selectedImage.value != null) {
                        profileController.sendUserData();
                        Get.offAll(MainScreen());
                      } else {
                        Get.snackbar("Error", "Please select an image");
                      }
                    }
                  },
                );
              }),

            ],
          ),
        ),
      ),
    );
  }

  bool _validateInputs() {
    bool isValid = true;
    String name = profileController.nameController.text.trim();

    String email = profileController.emailController.text.trim();
    String phone = profileController.phoneController.text.trim();

    if (!_isValidEmail(email)) {
      emailError.value = "Enter a valid email address";
      isValid = false;
    } else {
      emailError.value = "";
    }

    if (!_isValidPhone(phone)) {
      phoneError.value = "Enter a valid 10-digit phone number";
      isValid = false;
    } else {
      phoneError.value = "";
    }
    if (!_isValidName(name)) {
      nameError.value = "Name can't be empty or invalid";
      isValid = false;
    } else {
      nameError.value = "";
    }


    return isValid;
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    final RegExp phoneRegex = RegExp(r"^\d{10}$");
    return phoneRegex.hasMatch(phone);
  }
  bool _isValidName(String name) {
    if (name.isEmpty) {
      return false; // ❌ Empty name
    }
    final RegExp nameRegex = RegExp(r"^[a-zA-Z\s]+$");
    return nameRegex.hasMatch(name);
  }


  Widget _buildTextField(String label, TextEditingController controller,
      {String? errorText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          keyboardType: label == "Phone Number"
              ? TextInputType.number
              : TextInputType.text,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white54),
            errorText: (errorText != null && errorText.isNotEmpty)
                ? errorText
                : null, // ✅ Fixed
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white54),
              borderRadius: BorderRadius.circular(8.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(8.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        if (errorText != null && errorText.isNotEmpty) ...[
          SizedBox(height: 5.h),
          // Text(errorText, style: TextStyle(color: Colors.red, fontSize: 12.sp)),
        ],
      ],
    );
  }

  Widget _buildProfileImage() {
    return Obx(() => Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              backgroundImage: profileController.selectedImage.value != null
                  ? FileImage(profileController.selectedImage.value!)
                      as ImageProvider
                  : const NetworkImage('https://via.placeholder.com/150'),
            ),
            InkWell(
              onTap: () => _showImagePickerDialog(),
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child:
                    Icon(Icons.camera_alt, color: Color(0xff50ba80), size: 20),
              ),
            ),
          ],
        ));
  }

  /// 🔹 Image Picker Dialog
  void _showImagePickerDialog() {
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
              onTap: () => profileController.pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Choose from Gallery"),
              onTap: () => profileController.pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
