import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myott/UI/Profile/screens/AccountSettingsScreen.dart';
import 'package:myott/UI/Profile/screens/Subscription_history_page.dart';
import 'package:myott/UI/Profile/screens/downloadPage.dart';
import 'package:myott/UI/Profile/screens/langSelectionScreen.dart';
import 'package:myott/UI/Profile/screens/wishlistPage.dart';





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
          InkWell(
            onTap: (){
              Get.to(SubscriptionHistoryScreen());

            },
              child: SettingItem(title: "Subscription History", icon: Icons.history)),
          SettingItem(title: "FAQ", icon: Icons.help_outline),
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

class SettingItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final bool isLogout;
  final VoidCallback? onTap; // Callback function for onTap

  const SettingItem({
    Key? key,
    required this.title,
    required this.icon,
    this.subtitle,
    this.isLogout = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: isLogout ? Colors.red : Colors.white, size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}