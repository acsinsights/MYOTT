import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Utils/app_text_styles.dart';
import '../../../utils/size_config.dart';
import '../../Movie/Controller/Movie_controller.dart';
import '../../TvSeries/TvSeries_details_page.dart';

class MovieSlider extends StatelessWidget {
  final MovieController movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        // Movie Slider
        SizedBox(
          height: (400 / 812.0) * screenHeight,
          child: Obx(() {
            return PageView.builder(
              controller: movieController.pageController,
              itemCount: movieController.featuredMovies.length,
              onPageChanged: movieController.updatePage,
              itemBuilder: (context, index) {
                var movie = movieController.featuredMovies[index];

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
                          bottom: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(movie.title, style: AppTextStyles.Headingb),
                              Text("${movie.duration} min | Director: Unknown", style: AppTextStyles.SubHeading2),
                              const SizedBox(height: 5),
                              Text(movie.description, style: AppTextStyles.SubHeading3),
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
                                  side: BorderSide(color: AppColors.white),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                ),
                                onPressed: () {
                                  // Logic to add to watch later
                                },
                                child: Text(
                                  "Watch Later",
                                  style: AppTextStyles.SubHeading2,
                                ),
                              ),

                              SizedBox(width: 10),

                              // Watch Now Button - Navigates to Details Page
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                ),
                                onPressed: () {
                                  // movieController.setSelectedMovie(movie);
                                },
                                icon: Icon(Icons.play_arrow, color: AppColors.white),
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
            count: movieController.featuredMovies.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.primary,
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
