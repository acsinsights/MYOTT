import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../Model/movie_model.dart';

class MovieController extends GetxController {
  var movies = <MovieModel>[].obs; // List of movies
  var isLoading = true.obs;
  var currentPage = 0.obs; // Observable for the current page
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(viewportFraction: 0.9);
    fetchMovies();
    _autoScroll();
    super.onInit();
  }

  void fetchMovies() {
    movies.assignAll([
      MovieModel(
        id: 1,
        title: "Red Carpet",
        imageUrl: "assets/images/banner.png",
        description: "A captivating drama in the world of Hollywood.",
        duration: 120,
      ),
      MovieModel(
        id: 2,
        title: "Midnight Shadows",
        imageUrl: "assets/images/banner2.png",
        description: "A thriller that keeps you on the edge.",
        duration: 130,
      ),
      MovieModel(
        id: 3,
        title: "Beyond the Stars",
        imageUrl: "assets/images/banner3.png",
        description: "A sci-fi adventure into the unknown.",
        duration: 110,
      ),
    ]);
  }


  void updatePage(int index) {
    currentPage.value = index;
  }

  void _autoScroll() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (pageController.hasClients) {
        int nextPage = currentPage.value + 1;
        if (nextPage >= movies.length) {
          nextPage = 0;
        }
        pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        currentPage.value = nextPage;
      }
    });
  }
}
