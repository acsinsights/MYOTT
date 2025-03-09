import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myott/UI/SplashScreen/splashScreen.dart';
import 'package:myott/services/auth_service.dart';
import 'Binding/auth_binding.dart';
import 'UI/Auth/Controller/auth_controller.dart';
import 'services/api_service.dart';
import 'services/translation_service.dart';
import 'UI/Auth/Login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(ApiService());
  await GetStorage.init();
  await TranslationService.loadTranslations();

  final box = GetStorage();
  String savedLang = box.read('language') ?? 'en';
  Get.put(AuthController(AuthService(ApiService()))); // Inject AuthController
  runApp(MyApp(savedLang: savedLang));
}

class MyApp extends StatelessWidget {
  final String savedLang;

  MyApp({required this.savedLang});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: TranslationService(),
          locale: TranslationService.getLocale(savedLang),
          fallbackLocale: Locale('en'),
          initialBinding: AuthBinding(),
          home: SplashScreen(),
        );
      },
    );
  }
}
