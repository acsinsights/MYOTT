import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Auth/register_screen.dart';

import '../../Home/Main_screen.dart';
import '../forgot_password_screen.dart';


class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void login() async {
   Get.to(MainScreen());

  }

  void forgotPassword() {
   Get.to(ForgotPasswordScreen());
    //Get.snackbar("Forgot Password", "Password reset link sent!", backgroundColor: Colors.green);
  }

  void googleSignIn() {
    //Get.snackbar("Google Sign-In", "Feature coming soon!", backgroundColor: Colors.blue);
  }

  void register() async {
    Get.to(MainScreen());
  }
}
