import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Audio/Controller/AudioController.dart';
import 'package:myott/UI/Components/ShimmerLoader.dart';
import 'package:myott/UI/Home/Controller/Home_controller.dart';
import '../../../Core/Utils/app_text_styles.dart';

class AudioSelection extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final AudioController audioController = Get.put(AudioController());

  @override
  Widget build(BuildContext context) {
    final List<int> colors = [
      0xFF3B3B98,
      0xFF8D4E3F,
      0xFF5D5D81,
      0xFF725285,
      0xFFA97E36,
      0xFF3B8D78,
      0xFF3B3B98,
      0xFF8D4E3F,
      0xFF5D5D81,
      0xFF725285,
      0xFFA97E36,
      0xFF3B8D78,
    ];
    return Obx(() {
      if (homeController.isLoading.value) {
        return SizedBox(
          height: 60, // Ensures proper alignment
          child: GestureDetector(
            onTap: (){

            },
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ShimmerLoader(
                    height: 160,
                    width: 100,
                    borderRadius: 12,
                  ),
                );
              },
            ),
          ),
        );
      }

      return SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: homeController.homePageData.value!.audios.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            var audio = homeController.homePageData.value!.audios[index];

            return GestureDetector(
              onTap: () => audioController.selectAudio(audio),
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 140,
                    height: 100,
                    decoration: BoxDecoration(
                       color: Color(colors[index % colors.length]),
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
// ✅ Define colors as integer hex values

