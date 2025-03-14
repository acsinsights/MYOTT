import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myott/UI/Home/Model/SliderItemModel.dart';
import '../../../services/api_service.dart';


class MovieSliderController extends GetxController {
  var featuredMovies = <SliderItemModel>[].obs;
  var currentIndex = 0.obs;
  final CarouselController carouselController = CarouselController(); // New Carousel Controller

  @override
  void onInit() {
    super.onInit();
  }


  void updatePage(int index) {
    currentIndex.value = index;
  }
}
