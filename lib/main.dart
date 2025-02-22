import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'UI/Auth/login_page.dart';
import 'UI/Movie/Controller/Movie_controller.dart';
import 'Utils/size_config.dart';


void main() {


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig.init(context); // ✅ Initialize globally before any screen loads
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyOtt',
          themeMode: ThemeMode.system,
          home:  LoginPage(),
        );
      },
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
