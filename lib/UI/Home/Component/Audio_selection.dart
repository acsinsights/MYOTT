import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/services/Home_service.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/UI/Components/ShimmerLoader.dart';
import 'package:myott/UI/Home/Controller/Home_controller.dart';
import '../../../Core/Utils/app_text_styles.dart';
import '../Controller/Audio_controller.dart';
import '../Model/Audio_Model.dart';

class AudioSelection extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController(HomeService(ApiService())));

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.isLoading.value) {
        return SizedBox(
          height: 60, // Ensures proper alignment
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3, // Showing 3 shimmer items as placeholders
            padding: EdgeInsets.symmetric(horizontal: 16), // Optimized padding
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0), // Space between shimmer items
                child: ShimmerLoader(
                  height: 160, // Same as CircleAvatar's diameter (radius * 2)
                  width: 100,
                  borderRadius: 12, // Fully rounded to match CircleAvatar
                ),
              );
            },
          ),
        );
      }

      return SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: homeController.audios.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            var audio = homeController.audios[index]; // Get audiouage item

            return GestureDetector(
              // onTap: () => homeController.selectaudiouage(audio),
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 140,
                    height: 100,
                    decoration: BoxDecoration(
                       color: Color(audio.color ?? 0xFF3B3B98).withOpacity(0.7), // ✅ Provide default color if null
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child:  Center(
                      child: Text(
                        audio.name,
                        style: AppTextStyles.SubHeadingb,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
