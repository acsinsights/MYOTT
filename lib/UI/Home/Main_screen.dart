import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Utils/app_colors.dart';

import 'Controller/mian_screen_controller.dart';

class MainScreen extends StatelessWidget {
  final MainScreenController controller = Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]), // Ensure `.value` is used
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, size: 30, color: AppColors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.background,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Obx(() => Row( // Wrap in Obx to update UI
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
              SizedBox(width: 48), // Space for the floating button
              IconButton(
                icon: Icon(Icons.campaign,
                    color: controller.selectedIndex.value == 2
                        ? AppColors.white
                        : AppColors.white),
                onPressed: () => controller.changeIndex(2),
              ),
              IconButton(
                icon: Icon(Icons.person,
                    color: controller.selectedIndex.value == 3
                        ? AppColors.white
                        : AppColors.white),
                onPressed: () => controller.changeIndex(3),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
