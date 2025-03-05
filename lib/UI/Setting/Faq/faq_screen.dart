import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Services/Setting_service.dart';
import 'package:myott/Services/api_service.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';

import 'faq_controller.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FAQController faqController = Get.put(FAQController(SettingService(ApiService())));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("FAQs",style: AppTextStyles.Heading4,),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Obx(() {
        if (faqController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView.builder(
            itemCount: faqController.faqList.length,
            itemBuilder: (context, index) {
              final faq = faqController.faqList[index];

              return Obx(() => Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question
                    Text(
                      "${index + 1}. ${faq.question}",
                      style: AppTextStyles.SubHeadingb1
                    ),
                    SizedBox(height: 5),

                    // Answer with Expand/Collapse
                    Text(
                      faq.answer,
                      style: AppTextStyles.SubHeadingw3,
                      maxLines: faqController.expandedIndexes[index]?.value ?? false ? null : 2,
                      overflow: faqController.expandedIndexes[index]?.value ?? false
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),

                    // Read More / Read Less Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          faqController.toggleExpansion(index);
                        },
                        child: Text(
                          faqController.expandedIndexes[index]?.value ?? false ? "Read Less" : "Read More",
                          style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
            },
          ),
        );
      }),
    );
  }
}
