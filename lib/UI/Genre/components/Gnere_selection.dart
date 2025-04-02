import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/services/Home_service.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/UI/Home/Controller/Home_controller.dart';
import '../../../Core/Utils/app_text_styles.dart';
import '../../Components/ShimmerLoader.dart';
import '../Controller/genre_controller.dart';
import '../Model/genre_model.dart';

class GenreSelection extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final GenreController genreController = Get.put(GenreController());

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

    return Obx((){
      if (homeController.isLoading.value) {
        return SizedBox(
          height: 60, // Ensures proper alignment
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
        );
      }
      return SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: homeController.homePageData.value!.genre.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            HomeGenreModel genre = homeController.homePageData.value!.genre[index];

            return GestureDetector(
              onTap: () => genreController.selectGenre(genre),
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Container(
                  width: 140,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(colors[index % colors.length]),
                    borderRadius: BorderRadius.circular(12),

                  ),
                  child: Center(
                    child: Text(
                        genre.name,
                        style: AppTextStyles.SubHeadingb
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
