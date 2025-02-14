import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'UI/Auth/login_page.dart';
import 'Utils/size_config.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyOtt',

      themeMode: ThemeMode.system,
      home: const InitScreen(), // ✅ Initialize `SizeConfig` globally
    );
  }
}

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context); // ✅ Initialize once
    return  LoginPage(); // ✅ Now all screens can use `SizeConfig`
  }
}
