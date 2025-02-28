import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'languageController.dart'; // Import your LanguageController

class LanguageSelectionPage extends StatelessWidget {
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Languages".tr, style: TextStyle(color: Colors.white)),
      ),
      body: Obx(() {
        if (languageController.locale.value.isEmpty) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        }

        // Example: Replace this with your actual API-fetched language list
        List<Map<String, String>> langList = [
          {'code': 'en', 'name': 'English'},
          {'code': 'hi', 'name': 'हिन्दी'},
          {'code': 'ar', 'name': 'العربية'},
          {'code': 'zh', 'name': '中文'},
        ];

        return ListView.builder(
          itemCount: langList.length,
          itemBuilder: (context, index) {
            final language = langList[index];

            return ListTile(
              title: Text(language['name']!, style: TextStyle(color: Colors.white, fontSize: 18)),
              trailing: languageController.locale.value == language['code']
                  ? Icon(Icons.check_circle, color: Colors.white)
                  : null,
              onTap: () {
                print("Language selected: ${language['code']}"); // Debug
                languageController.changeLanguage(language['code']!);
                print("Language changed to: ${languageController.locale.value}"); // Debug
              },

            );
          },
        );
      }),
    );
  }
}
