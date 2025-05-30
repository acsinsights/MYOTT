import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Home/home_screen.dart';
import 'package:myott/UI/Wishlist/wishlist_page.dart';
import '../../Profile/profile_screen.dart';
import '../../Search/search_screen.dart';
import '../dramaboxHomeScreen.dart';



class MainScreenController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> screens = [
    // HomeScreen(),
    Dramaboxhomescreen(),
    SearchScreen(),
    ShowWishlistPage(),
    ProfileScreen(),
  ];
}
