import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Model/coming_soon_model.dart';

class ComingSoonController extends GetxController {
  var comingSoonMovies = <ComingSoonModel>[].obs;
  var currentPage = 0.obs;
  Timer? _timer;

  @override
  void onInit() {
    loadStaticMovies();
    if (comingSoonMovies.isNotEmpty) {
      startAutoScroll();
    }
    super.onInit();
  }

  void startAutoScroll() {
    _timer?.cancel(); // Cancel previous timer before starting a new one
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (comingSoonMovies.isEmpty) return;

      int nextPage = currentPage.value + 1;
      if (nextPage >= comingSoonMovies.length) {
        nextPage = 0;
      }



      currentPage.value = nextPage;
    });
  }

  void loadStaticMovies() {
    comingSoonMovies.assignAll([
      ComingSoonModel(
        title: "Red Carpet",
        imageUrl: "assets/images/CommingSoon/comming_movie.png",
        releaseYear: 2025,
        director: "Keith Johnson",
        description: "'Red Carpet' is a captivating drama in Hollywood.",
      ),
      ComingSoonModel(
        title: "Midnight Shadows",
        imageUrl: "assets/images/CommingSoon/bigmovie1.jpg",
        releaseYear: 2026,
        director: "Anna Smith",
        description: "A thriller that keeps you on the edge.",
      ),
      ComingSoonModel(
        title: "Beyond the Stars",
        imageUrl: "assets/images/CommingSoon/bigmovie2.jpg",
        releaseYear: 2025,
        director: "John Doe",
        description: "A sci-fi adventure exploring the unknown galaxies.",
      ),
    ]);
  }

  void notifyUser(BuildContext context, String movieTitle) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "You will be notified when $movieTitle is released!",
          style: GoogleFonts.poppins(),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
