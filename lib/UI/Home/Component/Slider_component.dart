import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Utils/app_text_styles.dart';
import '../../../utils/size_config.dart';
import '../../Movie/Controller/Movie_controller.dart';

class MovieSlider extends StatelessWidget {
  final MovieController movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Movie Slider
        SizedBox(
          height: SizeConfig.height(400),
          child: Obx(() {
            return PageView.builder(
              controller: movieController.pageController,
              itemCount: movieController.movies.length,
              onPageChanged: movieController.updatePage, // No need for setState
              itemBuilder: (context, index) {
                var movie = movieController.movies[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        // Background Image
                        Image.asset(
                          movie.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),

                        // Dark Gradient Overlay
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),

                        // Movie Info
                        Positioned(
                          left: 16,
                          bottom: 80, // Adjusted for buttons
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(movie.title, style: AppTextStyles.heading),
                              Text("${movie.duration} min | Director: Unknown", style: AppTextStyles.subText),
                              const SizedBox(height: 5),
                              Text(movie.description, style: AppTextStyles.subText2),
                            ],
                          ),
                        ),

                        // Buttons: "Watch Now" and "Watch Later"
                        Positioned(
                          left: 16,
                          bottom: 20,
                          child: Row(
                            children: [
                              // Watch Later Button
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.white),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                ),
                                onPressed: () {
                                  // Get.to(() => MovieDetailScreen(movie: movie));
                                },
                                child: Text(
                                  "Watch Later",
                                  style: AppTextStyles.subText,
                                ),
                              ),

                              SizedBox(width: 10),

                              // Watch Now Button
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                ),
                                onPressed: () {
                                  // Get.to(() => MovieDetailScreen());
                                },
                                icon: Icon(Icons.play_arrow, color: Colors.white),
                                label: Text(
                                  "Watch Now",
                                  style: AppTextStyles.buttonText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),

        const SizedBox(height: 10),

        // Dot Indicator
        Obx(() {
          return SmoothPageIndicator(
            controller: movieController.pageController,
            count: movieController.movies.length,
            effect: ExpandingDotsEffect(
              activeDotColor: Colors.red,
              dotColor: Colors.white,
              dotHeight: 8,
              dotWidth: 8,
              spacing: 6,
            ),
          );
        }),
      ],
    );
  }
}
