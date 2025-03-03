import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/Core//Utils/app_colors.dart';

import 'Controller/mian_screen_controller.dart';

class MainScreen extends StatelessWidget {
  final MainScreenController controller = Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]), // Ensure `.value` is used

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
              IconButton(
                icon: Icon(Icons.favorite,
                    color: controller.selectedIndex.value == 2
                        ? AppColors.primary2
                        : AppColors.white),
                onPressed: () => controller.changeIndex(2),
              ),
              IconButton(
                icon: Icon(Icons.campaign,
                    color: controller.selectedIndex.value == 3
                        ? AppColors.primary2
                        : AppColors.white),
                onPressed: () => controller.changeIndex(3),
              ),
              IconButton(
                icon: Icon(Icons.person,
                    color: controller.selectedIndex.value == 4
                        ? AppColors.primary2
                        : AppColors.white),
                onPressed: () => controller.changeIndex(4),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
