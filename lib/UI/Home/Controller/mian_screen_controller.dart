import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Home/home_screen.dart';
import 'package:myott/UI/Reels/reels_page.dart';
import 'package:myott/UI/Wishlist/wishlist_page.dart';

import '../../Profile/Components/CompleteProfileScreen.dart';
import '../../Profile/profile_screen.dart';
import '../../Search/search_screen.dart';



class MainScreenController extends GetxController {
  var selectedIndex = 0.obs; // Observable index

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    WishlistPage(),
    CompleteProfileScreen(),
    // ProfileScreen(),
  ];
}
