import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myott/UI/Home/Main_screen.dart';

import '../Auth/Controller/auth_controller.dart';
import '../Auth/Login/login_page.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController authController = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    checkTokenAndNavigate();
  }

  Future<void> checkTokenAndNavigate() async {
    if (await authController.isTokenExpired()) {
      print("🔴 Token expired, redirecting to login...");
      Get.to(LoginPage());
    } else {
      print("✅ Token is still valid, navigating to Home.");
      Get.to(MainScreen());  // Change as per your app's home screen
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
