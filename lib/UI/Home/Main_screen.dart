import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myott/Core//Utils/app_colors.dart';

import 'Controller/mian_screen_controller.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainScreenController controller = Get.put(MainScreenController());
  int selectedIndex = 0; // ✅ Yaha store hoga proper index
  DateTime? lastBackPress;

  Future<bool> onBackPressed() async {
    if (selectedIndex != 0) {
      setState(() {
        selectedIndex = 0;
      });
      return false;
    } else {
      DateTime now = DateTime.now();
      if (lastBackPress == null || now.difference(lastBackPress!) > Duration(seconds: 2)) {
        lastBackPress = now;
        Fluttertoast.showToast(
          msg: "Press back again to exit",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
        );
        return false;
      }
      SystemNavigator.pop();
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackPressed(),
      child: Scaffold(
        body: controller.screens[selectedIndex], // ✅ GetX nahi use kiya yaha
        bottomNavigationBar: BottomAppBar(
          color: AppColors.background,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(Icons.home, 0),
                _buildNavItem(Icons.search, 1),
                _buildNavItem(Icons.favorite, 2),
                _buildNavItem(Icons.person, 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return IconButton(
      icon: Icon(icon, color: selectedIndex == index ? AppColors.primary2 : AppColors.white),
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}
