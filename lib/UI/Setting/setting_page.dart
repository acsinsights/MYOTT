import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myott/Core/Utils/app_colors.dart';
import 'package:myott/UI/Auth/Controller/auth_controller.dart';
import 'package:myott/UI/Setting/Blogs/blog_page.dart';
import 'package:myott/UI/Setting/HelpAndSupport/supportType.dart';
import 'package:myott/UI/Setting/Pages/Components/AboutusPage.dart';
import 'package:myott/UI/Setting/Setting_Controller.dart';
import 'package:myott/UI/Setting/Wallet/wallet_Screen.dart';
import 'package:myott/UI/Setting/account_setting/AccountSettingsScreen.dart';
import 'package:myott/UI/Setting/Subscription_History/Subscription_history_page.dart';
import 'package:myott/UI/Setting/language/langSelectionScreen.dart';
import 'package:myott/UI/Setting/Faq/faq_screen.dart';
import 'package:myott/UI/WatchHistory/WatchHistoryPage.dart';

import '../Components/custom_button.dart';
import '../Profile/Components/SettingItem.dart';
import 'Components/FooterWidget.dart';
import 'Pages/Components/PrivacyPolicy.dart';
import 'Pages/Components/TermsAndCondition.dart';
import 'PaymentHistory/Payment_historypage.dart';


class HelpAndSettingScreen extends StatelessWidget {
  const HelpAndSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingController settingController=SettingController();
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
                Get.to(WalletScreen());
              },
              title: "Wallet".tr, icon: Icons.wallet),
          // SettingItem(
          //     onTap: (){
          //       Get.to(WatchHistoryPage());
          //     },
          //     title: "WatchHistory".tr, icon: Icons.history_toggle_off),
          // SettingItem(
          //     onTap: (){
          //       Get.to(SubscriptionHistoryScreen());
          //
          //     },
          //     title: "Subscription".tr, icon: Icons.history),
          SettingItem(
              onTap: (){
                Get.to(PaymentHistoryPage());

              },
              title: "Payment History".tr, icon: Icons.history),
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
          SettingItem(
              onTap: (){
                Get.to(PrivacyPolicy());
              },
              title: "Privacy".tr, icon: Icons.lock_outline),
          SettingItem(
            onTap:  () {
              Get.to(TermsAndCondition());
            },
              title: "Terms".tr, icon: Icons.article_outlined),

          SettingItem(
              title: "Refund".tr,
              icon: Icons.receipt_long_outlined),
          SettingItem(
            onTap: ()async{
              Get.defaultDialog(
                title: "Are you sure?",
                titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                backgroundColor: Colors.white,
                radius: 10,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Do you really want to delete your account? This action cannot be undone.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 20), // Space between text and buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Cancel Button
                        Expanded(
                          child: CustomButton(
                            text: "Cancel",
                            onPressed: () => Get.back(),
                            backgroundColor: AppColors.transparent,
                            borderColor: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10), // Space between buttons
                        // Yes (Delete) Button
                        Expanded(
                          child: CustomButton(
                            text: "Delete",
                            onPressed: () async {
                              Get.back();
                              await settingController.deleteAccount();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );


            },


              title: "Deletion".tr, icon: Icons.delete_outline),
          Divider(color: Colors.grey[800]),

          // Repeated Sections
          SettingItem(
            onTap: (){
              Get.to(AboutUsPage());
            },

              title: "About".tr, icon: Icons.info_outline),

          Divider(color: Colors.grey[800]),

          // Logout
          SettingItem(
            onTap: (){
              AuthController authcontroller=Get.find<AuthController>();
              authcontroller.logout();
            },
              title: "Logout".tr, icon: Icons.logout, isLogout: true),

          FooterWidget(
            facebookUrl: "https://www.facebook.com/",
            linkedinUrl: "https://linkedin.com/",
            twitterUrl: "https://twitter.com/",
            instagramUrl: "https://instagram.com/",
          ),

          SizedBox(height: 25),

        ],
      ),
    );
  }
}

