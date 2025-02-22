import 'package:get/get.dart';
import 'package:myott/UI/Home/home_screen.dart';


class AppRoutes {
  static const String home = '/';
  static const String movieDetails = '/movie_details';
  static const String moviesByLanguage = '/movies_by_language';

  static List<GetPage> pages = [
    GetPage(name: home, page: () => HomeScreen()),
   // GetPage(name: moviesByLanguage, page: () => MoviesByLanguagePage()),

    // GetPage(name: movieDetails, page: () => MovieDetailsPage()),
  ];
}
