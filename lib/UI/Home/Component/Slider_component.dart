import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myott/UI/Components/ShimmerLoader.dart';
import 'package:myott/UI/Movie/Movie_details_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:myott/services/Home_service.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/UI/Home/Controller/Home_controller.dart';
import '../../../Core/Utils/app_colors.dart';
import '../../../Core/Utils/app_text_styles.dart';
import '../../TvSeries/TvSeries_details_page.dart';
import '../Controller/MovieSliderController.dart';

class MovieSlider extends StatelessWidget {
  final MovieSliderController movieSliderController = Get.put(MovieSliderController());
  final HomeController homeController = Get.put(HomeController(HomeService(ApiService())));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 400.h,
          child: Obx(() {
            if (homeController.homePageData.value!.slider.isEmpty) {
              return ShimmerLoader(
                height: 400.h,
              );
            }

            return CarouselSlider.builder(
              itemCount: homeController.homePageData.value!.slider.length,
              itemBuilder: (context, index, realIndex) {
                var movie = homeController.homePageData.value!.slider[index];

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Stack(
                      children: [
                        Image.network(

                          movie.content.posterImg.toString(),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return ShimmerLoader(
                              height: 400.h,
                            );
                          },
                        ),

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
                          left: 16.w,
                          bottom: 80.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(movie.content.name, style: AppTextStyles.Headingb,overflow: TextOverflow.ellipsis,),
                              const SizedBox(height: 5),
                              Text(movie.content.description.toString(), style: AppTextStyles.SubHeading3),
                            ],
                          ),
                        ),

                        // Buttons: "Watch Now" and "Watch Later"
                        Positioned(
                          left: 16.w,
                          bottom: 20.h,
                          child: Row(
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: AppColors.white),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                                ),
                                onPressed: () {
                                },
                                child: Text(
                                  "Watch Later",
                                  style: AppTextStyles.SubHeading2,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                                ),
                                onPressed: () {
                                  final content = homeController.homePageData.value!.slider[index].content;

                                  if (content.type == 'movie') {
                                    Get.to(MovieDetailsPage(movieId: content.id));
                                  } else if (content.type == 'tvseries') {
                                    Get.to(TvSeriesDetailsPage(seriesId: content.id));
                                  } else {
                                    Get.snackbar("Error", "Unknown content type");
                                  }
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
                height: 400.h, // Responsive height
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

        SizedBox(height: 10.h), // Responsive spacing

        // Dot Indicator
        Obx(() {
          int currentIndex = movieSliderController.currentIndex.value;
          int totalSlides = homeController.homePageData.value!.slider.length;

          // Ensure currentIndex is within range
          if (currentIndex.isNaN || currentIndex.isInfinite || currentIndex < 0) {
            currentIndex = 0;
          }

          // Ensure totalSlides is valid
          if (totalSlides.isNaN || totalSlides.isInfinite || totalSlides <= 0) {
            totalSlides = 1;
          }

          return AnimatedSmoothIndicator(
            activeIndex: currentIndex,
            count: totalSlides,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.primary,
              dotColor: Colors.white,
              dotHeight: 8.h, // Responsive dot height
              dotWidth: 8.w, // Responsive dot width
              spacing: 6.w, // Responsive spacing
            ),
          );
        }),
      ],
    );
  }
}
