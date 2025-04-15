import 'package:flutter/cupertino.dart';
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
  int selectedIndex = 0; //
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
    return Obx(() => WillPopScope(
      onWillPop: () => onBackPressed(),
      child: Scaffold(
        body: controller.screens[selectedIndex],
        bottomNavigationBar: SafeArea(
          child: BottomAppBar(
            color: AppColors.background,
            child: SizedBox(
              height: 60, // Fixed height avoids overflow
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(child: _buildNavItem(Icons.home, 0, "Home")),
                  Flexible(child: _buildNavItem(Icons.search, 1, "Search")),
                  Flexible(child: _buildNavItem(Icons.favorite, 2, "MyList")),
                  Flexible(child: _buildNavItem(CupertinoIcons.profile_circled, 3, "Profile")),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }


  Widget _buildNavItem(IconData icon, int index, String text) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ? AppColors.primary2 : AppColors.subText,
          ),
          SizedBox(height: 2),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? AppColors.primary2 : AppColors.subText,
            ),
          ),
        ],
      ),
    );
  }
}
