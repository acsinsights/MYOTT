import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Setting/Pages/Controller/DynamicPageController.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DynamicPageController dynamicPageController = Get.put(DynamicPageController());

    return Scaffold(
      appBar: AppBar(
        title: Text("About Us",style: AppTextStyles.Headingb4,),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Obx(() {
          if (dynamicPageController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          final pages = dynamicPageController.aboutUs;

          if (pages.isEmpty) {
            return Center(
              child: Text(
                "No Content Available",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: pages.length,
            itemBuilder: (context, index) {
              final page = pages[index];

              return Card(

                color: Colors.grey[900],
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        page.title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      HtmlWidget(page.description,textStyle: TextStyle(color: Colors.white),)

                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
