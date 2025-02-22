import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/Utils/app_colors.dart';
import 'package:myott/Utils/app_text_styles.dart';
import '../Controller/coming_soon_controller.dart';

class ComingSoonWidget extends StatelessWidget {
  final ComingSoonController controller = Get.put(ComingSoonController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.comingSoonMovies.isEmpty) {
        return Center(child: Text("No upcoming movies available.", style: TextStyle(color: AppColors.white)));
      }

      return SizedBox(
        height: 350, // Adjust height as needed
        child: PageView.builder(
          controller: controller.pageController,
          itemCount: controller.comingSoonMovies.length,
          physics: BouncingScrollPhysics(),
          onPageChanged: (index) {
            controller.currentPage.value = index;
            controller.startAutoScroll(); // Restart auto-scroll when user scrolls manually
          },
          itemBuilder: (context, index) {
            var movie = controller.comingSoonMovies[index];

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    movie.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 10),

                  Text(movie.title, style: AppTextStyles.HeadingbRed2),
                  SizedBox(height: 5),

                  Text("2025 | DIRECTOR: Unknown", style: AppTextStyles.SubHeading2),
                  SizedBox(height: 5),

                  Text(
                    movie.description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 10),

                  ElevatedButton.icon(
                    onPressed: () => controller.notifyUser(context, movie.title),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    icon: Icon(Icons.notifications, color: Colors.white),
                    label: Text("Notify", style: GoogleFonts.poppins(fontSize: 16)),
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
