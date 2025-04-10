import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myott/UI/Home/Main_screen.dart';
import 'package:myott/UI/Setting/Setting_Controller.dart';
import 'package:myott/UI/SplashScreen/splashScreen.dart';
import 'package:myott/services/Setting_service.dart';
import 'package:myott/services/api_endpoints.dart';
import 'package:myott/services/auth_service.dart';
import 'Binding/auth_binding.dart';
import 'Config/light_theme.dart';
import 'UI/Auth/Controller/auth_controller.dart';
import 'UI/Home/Controller/themeController.dart';
import 'services/api_service.dart';
import 'services/translation_service.dart';
import 'UI/Auth/Login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeController = Get.put(ThemeController());
  await themeController.loadTheme(); // load from prefs

  Get.put(ApiService());
  await GetStorage.init();
  await TranslationService.loadTranslations();
  Stripe.publishableKey =
  "pk_test_51R3woGCG37UV7MBEuZDyX1QGvAqSY4yxaBUduJyQRX18ucxrozR6ezq6CPSWF0VzJ0JfmlJYeO5KAuAfTYFl8HSp00zD5Er2RF";

  final box = GetStorage();
  String savedLang = box.read('language') ?? 'en';
  Get.put(AuthController(AuthService(ApiService())));
  Get.put(SettingController());
  runApp(MyApp(savedLang: savedLang));
}

class MyApp extends StatelessWidget {
  final String savedLang;
  final ThemeController themeController = Get.find();


  MyApp({required this.savedLang});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(() {
          return GetMaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeController.isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            translations: TranslationService(),
            locale: TranslationService.getLocale(savedLang),
            fallbackLocale: Locale('en'),
            initialBinding: AuthBinding(),
            // home: MainScreen(),
            home: SplashScreen(),
          );
        });
      },
    );
  }
}
