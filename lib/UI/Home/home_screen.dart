import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Components/VideoList.dart';
import 'package:myott/UI/Profile/Controller/ProfileController.dart';
import '../../services/Home_service.dart';
import '../../services/api_service.dart';
import '../../services/tv_series_service.dart';
import '../Components/Movie_grid.dart';
import '../Components/TvSeriesGrid.dart';
import '../Components/ShimmerLoader.dart';
import '../Components/movie_list.dart';
import '../Components/section_title.dart';
import '../Genre/components/Gnere_selection.dart';
import '../Home/Component/Audio_selection.dart';
import '../Home/Controller/Home_controller.dart';
import '../TvSeries/Controller/tv_series_controller.dart';
import '../Actors/Components/actor_list.dart';
import '../Components/MovieListShrimerLoad.dart';
import '../TvSeries/Component/TvShowList.dart';
import 'Component/Slider_component.dart';
import 'Component/coming_soon_widget.dart';
import 'Component/latest_movie_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    ProfileController profileController=Get.put(ProfileController());


    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            if (homeController.isLoading.value) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ShimmerLoader(height: 400.h),
                    SizedBox(height: 20,),
                    MovieShrimmerLoader(),
                    SizedBox(height: 20,),
                    MovieShrimmerLoader(),
                    SizedBox(height: 20,),
                    MovieShrimmerLoader(),
                    SizedBox(height: 20,),
                  ],
                ),
              );
            }

            final homeData = homeController.homePageData.value;

            if (homeData == null) {
              return Center(child: Text("No data available", style: TextStyle(color: Colors.white)));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                MovieSlider(),
                if (homeData.latest.movies.isNotEmpty || homeData.latest.series.isNotEmpty) ...[
                  SectionTitle(
                    title: "Latest".tr,
                    showAll: false,
                  ),
                  LatestMandSList(movies: homeData.latest.movies, series: homeData.latest.series)
                ],
                if (homeData.top10.isNotEmpty) ...[
                  SectionTitle(
                    title: "Top 10".tr,
                    onTap: () => Get.to(MovieGrid(

                      movies: homeData.top10,
                      title: "Top 10".tr,
                    )),
                  ),
                  MovieList(movies: homeData.top10.take(10).toList(), isTop10: true),
                ],

                ActorList(),

                if (homeData.series.isNotEmpty || homeData.series.isNotEmpty) ...[
                  SectionTitle(
                    title: "TV Series".tr,
                    onTap: () => Get.to(TvSeriesGrid(
                      tvSeries: homeData.series,
                      title: "TV Series".tr,
                    )),
                  ),
                  TvSeriesMovieList(tvSeries: homeData.series),
                ],

                if (homeData.audios.isNotEmpty) ...[
                  SectionTitle(title: "Languages".tr,showAll: false,),
                  AudioSelection(),
                ],

                if (homeData.newArrival.isNotEmpty) ...[
                  SectionTitle(
                    title: "New Arrival".tr,
                    onTap: () => Get.to(MovieGrid(
                      movies: homeData.newArrival,
                      title: "New Arrival".tr,
                    )),
                  ),
                  MovieList(movies: homeData.newArrival),
                ],
                if (homeData.video.isNotEmpty) ...[
                  SectionTitle(
                    title: "Videos".tr,
                    showAll: false,
                  ),
                  VideoList(videos: homeData.video),
                ],

                if (homeData.genre.isNotEmpty) ...[
                  SectionTitle(title: "Genre".tr,showAll: false,),
                  GenreSelection(),
                ],

                const SizedBox(height: 20),
                ComingSoonWidget(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
