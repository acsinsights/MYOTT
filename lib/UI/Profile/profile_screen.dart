import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Home/Controller/themeController.dart';
import 'package:myott/UI/Profile/Components/SettingItem.dart';

import 'package:myott/UI/Profile/Components/SubscriptionBanner.dart';
import 'package:myott/UI/Profile/Components/UserProfile.dart';

import 'package:myott/UI/Setting/setting_page.dart';

import '../Setting/HelpAndSupport/supportType.dart';
import 'Components/WatchHistoryHorizontalList.dart';

class ProfileScreen extends StatelessWidget {
  final ThemeController controller = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).appBarTheme.shadowColor, // 👈 Recommended
        elevation: 0,
        title: Text(
          "Profile".tr,
          style: AppTextStyles.Headingb4
        ),
        actions: [
          // Obx(() {
          //   return IconButton(
          //     icon: Icon(
          //       controller.isDarkMode.value ? Icons.light_mode : Icons.dark_mode,
          //       color: Theme.of(context).iconTheme.color, // 👈 Icon color dynamic
          //     ),
          //     onPressed: controller.toggleTheme,
          //   );
          // }),
          // IconButton(
          //   icon: Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
          //   onPressed: () => Get.to(HelpAndSettingScreen()),
          // ),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h,),
            SubscriptionBanner(),
            UserProfile(),
            SizedBox(height: 16),
            Text(
              "Recently Watched",
              style: AppTextStyles.Headingb4,
            ),
            SizedBox(height: 10),
            WatchHistoryHorizontalList(), // ✅ Add
            SizedBox(height: 10),

            SettingItem(title: "Settings", icon: Icons.settings,
            onTap: (){
              Get.to(HelpAndSettingScreen());
            },),
            SettingItem(title: "Support".tr, icon: Icons.help,
              onTap: (){
                Get.to(SupportTypePage());
              },
            ),
          ],
        ),
      ),
    );
  }


}