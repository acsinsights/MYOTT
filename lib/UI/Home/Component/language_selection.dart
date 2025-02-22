import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Utils/app_text_styles.dart';
import '../Controller/language_controller.dart';
import '../Model/language_model.dart';

class LanguageSelection extends StatelessWidget {
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: languageController.languages.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          LanguageModel lang = languageController.languages[index];

          return GestureDetector(
            onTap: () => languageController.selectLanguage(lang),
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    // Background Image
                    Image.asset(
                      lang.image,
                      width: 160,
                      height: 100,
                      fit: BoxFit.cover,
                    ),

                    // Color Overlay
                    Container(
                      width: 160,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(lang.color).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    // Text Overlay
                    Positioned(
                      left: 16,
                      top: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.name,
                            style:AppTextStyles.SubHeadingb
                          ),
                          const SizedBox(height: 4),
                          Text(
                            lang.translation,
                            style: AppTextStyles.SubHeading2
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
