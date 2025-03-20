import 'package:get/get.dart';
import 'package:myott/UI/Profile/Components/CompleteProfileScreen.dart';

import '../Binding/auth_binding.dart';
import '../UI/Auth/Login/login_page.dart';
import '../UI/Home/Main_screen.dart';
import 'app_routes.dart';



class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.LOGIN, page: () => LoginPage(), binding: AuthBinding()),
    GetPage(name: AppRoutes.PROFILE_CREATION, page: () => CompleteProfileScreen(), binding: AuthBinding()),
    GetPage(name: AppRoutes.HOME, page: () => MainScreen()),
  ];
}
