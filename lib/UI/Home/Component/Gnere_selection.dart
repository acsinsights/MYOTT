import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Utils/app_text_styles.dart';
import '../Controller/genre_controller.dart';
import '../Model/genre_model.dart';

class GenreSelection extends StatelessWidget {
  final GenreController genreController = Get.put(GenreController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genreController.genres.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          GenreModel genre = genreController.genres[index];

          return GestureDetector(
            onTap: () => genreController.selectGenre(genre),
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    // Background Image
                    Image.asset(
                      genre.image,
                      width: 160,
                      height: 100,
                      fit: BoxFit.cover,
                    ),

                    // Text Overlay
                    Positioned(
                      left: 16,
                      top: 10,
                      child: Text(
                        genre.name,
                        style: AppTextStyles.SubHeadingb
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
