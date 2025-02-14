import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Home/home_screen.dart';



class MainScreenController extends GetxController {
  var selectedIndex = 0.obs; // Observable index

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> screens = [
    HomeScreen(),
    //SearchScreen(),
    //ReelsScreen(),
    //ProfilePage(),
  ];
}
