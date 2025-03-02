import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myott/Services/Home_service.dart';
import 'package:myott/Services/api_service.dart';
import 'package:myott/UI/Home/Controller/Home_controller.dart';
import 'package:myott/Utils/app_colors.dart';
import '../../../Utils/app_text_styles.dart';
import '../../../utils/size_config.dart';
import '../../Movie/Controller/Movie_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Controller/MovieSliderController.dart';

class MovieSlider extends StatelessWidget {
  final MovieSliderController movieSliderController = Get.put(MovieSliderController());
  final HomeController homeController=Get.put(HomeController(HomeService(ApiService())));

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        // Movie Carousel Slider
        SizedBox(
          height: (400 / 812.0) * screenHeight,
          child: Obx(() {
            if (homeController.sliderMovies.isEmpty) {
              return Center(child: CircularProgressIndicator()); // Show loader while fetching
            }

            return CarouselSlider.builder(
              itemCount: homeController.sliderMovies.length,
              itemBuilder: (context, index, realIndex) {
                var movie = homeController.sliderMovies[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        // Background Image
                        Image.network(
                          movie.content.image != null && movie.content.image!.isNotEmpty
                              ? movie.content.image!
                              : "https://templatecookies.com/ott/public/uploads/movies/images/poster_img/1740810789_poster_02.png", // Placeholder image URL
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) => Image.asset(
                            "assets/images/movies/SliderMovies/movie-1.png", // Local placeholder image
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
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
                              Text(movie.content.name, style: AppTextStyles.Headingb),
                              // Text("${movie.duration} min | Director: Unknown", style: AppTextStyles.SubHeading2),
                              const SizedBox(height: 5),
                              Text(movie.content.description, style: AppTextStyles.SubHeading3),
                            ],
                          ),
                        ),

                        // Buttons: "Watch Now" and "Watch Later"
                        Positioned(
                          left: 16,
                          bottom: 20,
                          child: Row(
                            children: [
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
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                ),
                                onPressed: () {
                                  // homeController.setSelectedMovie(movie);
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
              options: CarouselOptions(
                height: (400 / 812.0) * screenHeight,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 16 / 9,
                onPageChanged: (index, reason) {
                  movieSliderController.updatePage(index); // Updating index for indicators
                },
              ),
            );
          }),
        ),

        const SizedBox(height: 10),

        // Dot Indicator
        Obx(() {
          return AnimatedSmoothIndicator(
            activeIndex: movieSliderController.currentIndex.value, // Use current index
            count: homeController.sliderMovies.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.primary,
              dotColor: Colors.white,
              dotHeight: 8,
              dotWidth: 8,
              spacing: 6,
            ),
          );
        }),      ],
    );
  }
}
