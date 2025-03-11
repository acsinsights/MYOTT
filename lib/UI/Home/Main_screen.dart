import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/Core//Utils/app_colors.dart';

import 'Controller/mian_screen_controller.dart';

class MainScreen extends StatelessWidget {
  final MainScreenController controller = Get.put(MainScreenController());
  DateTime? lastBackPress; // Stores last back press time

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.selectedIndex.value != 0) {
          // If not on the home screen, go to home screen
          controller.changeIndex(0);
          return false; // Prevent app from closing
        } else {
          // If already on home, handle double back press to exit
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
            return false; // Prevent exit on first back press
          }
          SystemNavigator.pop(); // Exit the app
          return true;
        }
      },
      child: Scaffold(
        body: Obx(() => controller.screens[controller.selectedIndex.value]),

        bottomNavigationBar: BottomAppBar(
          color: AppColors.background,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.home,
                      color: controller.selectedIndex.value == 0
                          ? AppColors.primary2
                          : AppColors.white),
                  onPressed: () => controller.changeIndex(0),
                ),
                IconButton(
                  icon: Icon(Icons.search,
                      color: controller.selectedIndex.value == 1
                          ? AppColors.primary2
                          : AppColors.white),
                  onPressed: () => controller.changeIndex(1),
                ),
                IconButton(
                  icon: Icon(Icons.favorite,
                      color: controller.selectedIndex.value == 2
                          ? AppColors.primary2
                          : AppColors.white),
                  onPressed: () => controller.changeIndex(2),
                ),
                IconButton(
                  icon: Icon(Icons.person,
                      color: controller.selectedIndex.value == 3
                          ? AppColors.primary2
                          : AppColors.white),
                  onPressed: () => controller.changeIndex(3),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
