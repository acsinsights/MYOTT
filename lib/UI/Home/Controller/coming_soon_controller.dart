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
