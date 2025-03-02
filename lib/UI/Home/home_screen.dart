import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Services/tv_series_service.dart';
import 'package:myott/UI/Components/ShimmerLoader.dart';
import 'package:myott/UI/Home/Component/actor_list.dart';
import 'package:myott/UI/Components/movie_list.dart';
import 'package:myott/UI/Components/section_title.dart';
import 'package:myott/UI/Genre/components/Gnere_selection.dart';
import 'package:myott/UI/Home/Component/Audio_selection.dart';
import 'package:myott/UI/Home/Controller/Home_controller.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/UI/TvSeries/tv_series_controller.dart';
import '../../Services/Home_service.dart';
import '../../Services/api_service.dart';
import '../Components/MovieListShrimerLoad.dart';
import '../TvSeries/Component/TvShowList.dart';
import 'Component/Slider_component.dart';
import 'Component/coming_soon_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController(HomeService(ApiService())));
    final TVSeriesController tvSeriesController =Get.put(TVSeriesController(TVSeriesService(ApiService())));


    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              MovieSlider(),
              const SizedBox(height: 20),

              SectionTitle(title: "latestRelease".tr),
              Obx(() {
                if (homeController.isLoading.value) {
                  return MovieShrimmerLoader();
                } else {
                  return MovieList(movies: homeController.latestMovies);
                }
              }),

               SizedBox(height: 10),


              SectionTitle(title: "Top10".tr),
              Obx(()=> homeController.isLoading.value
                  ?MovieShrimmerLoader()
                  : MovieList(movies: homeController.topMovies)),

              SectionTitle(title: "Actors".tr),
              ActorList(),
              SectionTitle(title: "TvSeries".tr),
              Obx(()=> homeController.isLoading.value
                  ?MovieShrimmerLoader()
                  : TvSeriesMovieList(tvSeries: tvSeriesController.tvSeries)),
              SectionTitle(title: "Sports".tr),
              //MovieList(movies: movieController.latestMovies ),

              SizedBox(height: 10,),



              SectionTitle(title: "Languages".tr),
              AudioSelection(),
              SizedBox(height: 10,),

              SectionTitle(title: "NewArrival".tr),
              // MovieList(movies: movieController.trendingMovies ),

              SectionTitle(title: "Genre".tr),
              GenreSelection(),
              SizedBox(height: 20,),
              ComingSoonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

