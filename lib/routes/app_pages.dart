import 'package:get/get.dart';
import 'package:myott/UI/Movie/Movie_details_page.dart';
import 'package:myott/UI/Profile/Components/CompleteProfileScreen.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import 'package:myott/UI/Video/video_Detials_page.dart';
import 'package:myott/video_player/component/verticalPlayerPage.dart';
import 'package:myott/video_player/component/verticalPlayerPagee.dart';

import '../Binding/auth_binding.dart';
import '../UI/Auth/Login/login_page.dart';
import '../UI/Home/Main_screen.dart';
import 'app_routes.dart';



class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.LOGIN, page: () => LoginPage(), binding: AuthBinding()),
    GetPage(name: AppRoutes.PROFILE_CREATION, page: () => CompleteProfileScreen(), binding: AuthBinding()),
    GetPage(name: AppRoutes.HOME, page: () => MainScreen()),
    GetPage(name: AppRoutes.MOVIEDETAILS, page: () => MovieDetailsPage(),arguments: {}),
    GetPage(name: AppRoutes.SPLASH, page: () => MainScreen()),
    GetPage(name: AppRoutes.TVSERIESDETAILS, page: () => TvSeriesDetailsPage(),arguments: {}),
    GetPage(name: AppRoutes.VIDEODETAILS, page: () => VideoDetialsPage(),arguments: {}),
    GetPage(name: AppRoutes.VERTICAlPLAYERPAGE, page: () => VerticalPlayerPagee(),arguments: {}),

  ];
}
