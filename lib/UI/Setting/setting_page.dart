import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myott/Services/Setting_service.dart';
import 'package:myott/UI/Setting/Blogs/blog_page.dart';
import 'package:myott/UI/Setting/account_setting/AccountSettingsScreen.dart';
import 'package:myott/UI/Setting/Subscription_History/Subscription_history_page.dart';
import 'package:myott/UI/Profile/screens/downloadPage.dart';
import 'package:myott/UI/Setting/language/langSelectionScreen.dart';
import 'package:myott/UI/Profile/screens/wishlistPage.dart';
import 'package:myott/UI/Setting/Faq/faq_screen.dart';

import '../Profile/Components/SettingItem.dart';





class HelpAndSettingScreen extends StatelessWidget {
  const HelpAndSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Help & Setting",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          SettingItem(
              onTap: (){
                Get.to(LanguageSelectionPage());
              },
              title: "App Language", icon: Icons.language),
          SettingItem(
            onTap: (){
              Get.to(AccountSettingsScreen());
            },
            title: "Account Settings",
            icon: Icons.person_outline,
            subtitle: "Subscription plan, device connected",
          ),
          SettingItem(
              onTap: (){
                Get.to(WatchlistScreen());
              },
              title: "Watchlist", icon: Icons.add),
          SettingItem(
              onTap: (){
                Get.to(Downloadpage());
              },
              title: "Downloads", icon: Icons.download),
          SettingItem(
              onTap: (){
                Get.to(SubscriptionHistoryScreen());

              },
              title: "Subscription History", icon: Icons.history),
          SettingItem(
              onTap: (){
                Get.to(FAQScreen());
              },
              title: "FAQ", icon: Icons.help_outline),
          SettingItem(
              onTap: (){
                Get.to(BlogScreen());
              },
              title: "Blogs", icon: Icons.comment),

          Divider(color: Colors.grey[800]),

          // Policy & Support
          SettingItem(title: "Privacy Policy", icon: Icons.lock_outline),
          SettingItem(title: "Terms & Conditions", icon: Icons.article_outlined),
          SettingItem(title: "Help and Support", icon: Icons.help),
          SettingItem(
              title: "Refund and Cancellation Policy",
              icon: Icons.receipt_long_outlined),
          SettingItem(
              title: "Data Deletion Request", icon: Icons.delete_outline),
          Divider(color: Colors.grey[800]),

          // Repeated Sections
          SettingItem(title: "About Us", icon: Icons.info_outline),
          SettingItem(title: "Help and Support", icon: Icons.help),
          SettingItem(
              title: "Refund and Cancellation Policy",
              icon: Icons.receipt_long_outlined),
          SettingItem(
              title: "Data Deletion Request", icon: Icons.delete_outline),
          SettingItem(title: "About Us", icon: Icons.info_outline),
          Divider(color: Colors.grey[800]),

          // Logout
          SettingItem(title: "Logout", icon: Icons.logout, isLogout: true),
        ],
      ),
    );
  }
}

