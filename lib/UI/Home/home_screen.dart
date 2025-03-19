import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Components/Movie_grid.dart';
import 'package:myott/UI/Components/TvSeriesGrid.dart';
import 'package:myott/services/tv_series_service.dart';
import 'package:myott/UI/Components/ShimmerLoader.dart';
import 'package:myott/UI/Components/movie_list.dart';
import 'package:myott/UI/Components/section_title.dart';
import 'package:myott/UI/Genre/components/Gnere_selection.dart';
import 'package:myott/UI/Home/Component/Audio_selection.dart';
import 'package:myott/UI/Home/Controller/Home_controller.dart';
import 'package:myott/UI/TvSeries/Controller/tv_series_controller.dart';
import '../../services/Home_service.dart';
import '../../services/api_service.dart';
import '../Actors/Components/actor_list.dart';
import '../Components/MovieListShrimerLoad.dart';
import '../TvSeries/Component/TvShowList.dart';
import 'Component/Slider_component.dart';
import 'Component/coming_soon_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController =
    Get.put(HomeController(HomeService(ApiService())));
    final TVSeriesController tvSeriesController =
    Get.put(TVSeriesController(TVSeriesService(ApiService())));

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Obx(() {
                if (homeController.isLoading.value) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ShimmerLoader(
                      height: 400.h,
                    ),
                  );
                }
                return MovieSlider();
              }),
              const SizedBox(height: 20),
              Obx(() {
                if (homeController.isLoading.value) {
                  return MovieShrimmerLoader();
                }
                if (homeController.homePageData.value!.latest.isEmpty) {
                  return SizedBox();
                }
                return Column(
                  children: [
                    SectionTitle(
                      title: "latestRelease".tr,
                      showAll: false,
                      onTap: () {
                        Get.to(
                          MovieGrid(
                            movies: homeController.homePageData.value!.latest,
                            // Correct way to pass list
                            title: "latestRelease".tr,
                          ),
                        );
                      },
                    ),
                    MovieList(
                        movies: homeController.homePageData.value!.latest),
                  ],
                );
              }),
              SizedBox(height: 10),
              Obx(() {
                if (homeController.isLoading.value) {
                  return MovieShrimmerLoader();
                }
                if (homeController.homePageData.value!.top10.isEmpty) {

                }
                return Column(
                  children: [
                    SectionTitle(
                      title: "Top10".tr,
                      showAll: false,
                      onTap: () {
                        Get.to(MovieGrid(
                          movies: homeController.homePageData.value!.top10,
                          title: "Top10".tr,
                        ));
                      },
                    ),
                    MovieList(
                        movies: homeController.homePageData.value!.top10
                            .take(10)
                            .toList(),
                        isTop10: true),
                  ],
                );
              }),

              ActorList(),

              Obx(() {
                if (homeController.isLoading.value) {
                  return MovieShrimmerLoader();
                }
                if (tvSeriesController.tvSeries.isEmpty) {
                  return SizedBox();
                }
                return Column(
                  children: [
                    SectionTitle(
                        title: "TvSeries".tr,
                        onTap: () {
                          Get.to(TvSeriesGrid(
                            tvSeries: tvSeriesController.tvSeries,
                            title: "TvSeries".tr,
                          ));
                        }),
                    TvSeriesMovieList(tvSeries: tvSeriesController.tvSeries),
                  ],
                );
              }),
              SizedBox(
                height: 10,
              ),
              Obx(() {
                if (homeController.homePageData.value!.audios.isEmpty) {
                  return SizedBox();
                }
                return SectionTitle(
                  title: "Languages".tr,
                  showAll: false,
                );
              }),
              AudioSelection(),
              SizedBox(
                height: 10,
              ),

              Obx(() {
                if (homeController.isLoading.value) {
                  return MovieShrimmerLoader();
                }
                if (homeController.homePageData.value!.newArrival.isEmpty) {
                  return SizedBox();
                }
                return Column(
                  children: [
                    SectionTitle(
                      title: "NewArrival".tr,
                      onTap: () async {
                        Get.to(MovieGrid(
                          movies: homeController.homePageData.value!.newArrival,
                          title: "NewArrival".tr,
                        ));
                      },
                    ),
                    MovieList(
                        movies: homeController.homePageData.value!.newArrival),
                  ],
                );
              }),
              Obx(() {
                if(homeController.homePageData.value!.genre.isEmpty){
                  return SizedBox();
                }
                return SectionTitle(
                  title: "Genre".tr,
                  showAll: false,
                );
              }),
              GenreSelection(),
              SizedBox(
                height: 20,
              ),
              ComingSoonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
