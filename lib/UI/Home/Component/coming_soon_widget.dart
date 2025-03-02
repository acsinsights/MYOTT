import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/Utils/app_colors.dart';
import 'package:myott/Utils/app_text_styles.dart';
import '../../../Services/Home_service.dart';
import '../../../Services/api_service.dart';
import '../Controller/Home_controller.dart';
import '../Controller/coming_soon_controller.dart';

class ComingSoonWidget extends StatelessWidget {
  final ComingSoonController controller = Get.put(ComingSoonController());
  final HomeController homeController = Get.put(HomeController(HomeService(ApiService())));

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.upcomingMovies.isEmpty) {
        return Center(
          child: Text(
            "No upcoming movies available.",
            style: TextStyle(color: AppColors.white),
          ),
        );
      }

      return Container(
        child: CarouselSlider.builder(
          itemCount: homeController.upcomingMovies.length,
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 0.85, // Adjusts width of each card
            enlargeCenterPage: false, // Zoom effect
            autoPlayInterval: Duration(seconds: 5),
            height: MediaQuery.of(context).size.height * 0.8, // ✅ Ensures it fits inside screen

          ),
          itemBuilder: (context, index, realIndex) {
            var movie = homeController.upcomingMovies[index];

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // 🔹 Ensures dynamic height
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      movie.thumbnailImg,
                      // height: 300,

                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset("assets/images/CommingSoon/bigmovie1.jpg"),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(movie.name, style: AppTextStyles.HeadingbRed2),
                  SizedBox(height: 5),
                  Text(
                    "${movie.releaseYear} | Director: Unknown",
                    style: AppTextStyles.SubHeading2,
                  ),
                  SizedBox(height: 5),
                  Text(
                    movie.description,
                    textAlign: TextAlign.center,
                    maxLines: 3, // Limit description lines
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () => controller.notifyUser(context, movie.name),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    icon: Icon(Icons.notifications, color: Colors.white),
                    label: Text("Notify".tr, style: GoogleFonts.poppins(fontSize: 16)),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
