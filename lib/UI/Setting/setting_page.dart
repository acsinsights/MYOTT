import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myott/UI/Setting/Blogs/blog_page.dart';
import 'package:myott/UI/Setting/Wallet/wallet_Screen.dart';
import 'package:myott/UI/Setting/account_setting/AccountSettingsScreen.dart';
import 'package:myott/UI/Setting/Subscription_History/Subscription_history_page.dart';
import 'package:myott/UI/Profile/screens/downloadPage.dart';
import 'package:myott/UI/Setting/language/langSelectionScreen.dart';
import 'package:myott/UI/Profile/screens/wishlistPage.dart';
import 'package:myott/UI/Setting/Faq/faq_screen.dart';

import '../Profile/Components/SettingItem.dart';
import 'Components/FooterWidget.dart';


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
          "Help".tr+ "&" "Setting".tr,
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
              title: "AppLang".tr, icon: Icons.language),
          SettingItem(
            onTap: (){
              Get.to(AccountSettingsScreen());
            },
            title: "Account".tr,
            icon: Icons.person_outline,
            subtitle: "subSubscription".tr,
          ),
          SettingItem(
              onTap: (){
                Get.to(WatchlistScreen());
              },
              title: "Watchlist".tr, icon: Icons.add),
          SettingItem(
              onTap: (){
                Get.to(WalletScreen());
              },
              title: "Wallet".tr, icon: Icons.wallet),
          SettingItem(
              onTap: (){
                Get.to(Downloadpage());
              },
              title: "Downloads".tr, icon: Icons.download),
          SettingItem(
              onTap: (){
                Get.to(SubscriptionHistoryScreen());

              },
              title: "Subscription".tr, icon: Icons.history),
          SettingItem(
              onTap: (){
                Get.to(FAQScreen());
              },
              title: "FAQ".tr, icon: Icons.help_outline),
          SettingItem(
              onTap: (){
                Get.to(BlogScreen());
              },
              title: "Blog".tr, icon: Icons.comment),

          Divider(color: Colors.grey[800]),

          // Policy & Support
          SettingItem(title: "Privacy".tr, icon: Icons.lock_outline),
          SettingItem(title: "Terms".tr, icon: Icons.article_outlined),
          SettingItem(title: "Support".tr, icon: Icons.help),
          SettingItem(
              title: "Refund".tr,
              icon: Icons.receipt_long_outlined),
          SettingItem(
              title: "Deletion".tr, icon: Icons.delete_outline),
          Divider(color: Colors.grey[800]),

          // Repeated Sections
          SettingItem(title: "About".tr, icon: Icons.info_outline),

          Divider(color: Colors.grey[800]),

          // Logout
          SettingItem(title: "Logout".tr, icon: Icons.logout, isLogout: true),

          FooterWidget(
            facebookUrl: "https://www.facebook.com/",
            linkedinUrl: "https://linkedin.com/",
            twitterUrl: "https://twitter.com/",
            instagramUrl: "https://instagram.com/",
          )

        ],
      ),
    );
  }
}

