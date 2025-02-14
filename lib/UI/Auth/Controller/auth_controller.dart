import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void login() async {
   // Get.to(MainScreen());

  }

  void forgotPassword() {
   // Get.to(page);
    //Get.snackbar("Forgot Password", "Password reset link sent!", backgroundColor: Colors.green);
  }

  void googleSignIn() {
    //Get.snackbar("Google Sign-In", "Feature coming soon!", backgroundColor: Colors.blue);
  }

  void register() async {
  }
}
