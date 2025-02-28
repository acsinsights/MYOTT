import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Services/translation_service.dart';
import 'UI/Auth/login_page.dart';
import 'UI/Movie/Controller/Movie_controller.dart';
import 'UI/Setting/language/languageController.dart';
import 'Utils/size_config.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();  // 🔥 Initialize persistent storage
  await TranslationService.loadTranslations(); // 🔥 Load language files

  // ✅ Read saved language from GetStorage (default to 'en' if not set)
  final box = GetStorage();
  String savedLang = box.read('language') ?? 'en';

  runApp(MyApp(savedLang: savedLang));
}

class MyApp extends StatelessWidget {
  final String savedLang;

  MyApp({required this.savedLang});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: TranslationService(),
      locale: TranslationService.getLocale(savedLang), // ✅ Set saved language as default
      fallbackLocale: Locale('en'),
      home: LoginPage(),
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
