import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Services/api_service.dart';
import 'Services/translation_service.dart';
import 'UI/Auth/Login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Initialize GetX services
  Get.put(ApiService());
  await GetStorage.init();
  await TranslationService.loadTranslations();

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
    return ScreenUtilInit(
      designSize: Size(375, 812),  // 🔥 Adjust to your design reference
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: TranslationService(),
          locale: TranslationService.getLocale(savedLang),
          fallbackLocale: Locale('en'),
          home: child,
        );
      },
      child: LoginPage(),  // ✅ Pass LoginPage as child
    );
  }
}
