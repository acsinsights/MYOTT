import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Services/tv_series_service.dart';
import 'package:myott/UI/Components/ShimmerLoader.dart';
import 'package:myott/UI/Home/Component/actor_list.dart';
import 'package:myott/UI/Components/movie_list.dart';
import 'package:myott/UI/Components/section_title.dart';
import 'package:myott/UI/Home/Component/Gnere_selection.dart';
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
    final MovieController movieController= Get.put(MovieController());
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

              SectionTitle(title: "Latest Release"),
              Obx(() {
                if (homeController.isLoading.value) {
                  return MovieShrimmerLoader();
                } else {
                  return MovieList(movies: homeController.latestMovies);
                }
              }),

               SizedBox(height: 10),


              SectionTitle(title: "Top 10"),
              Obx(()=> homeController.isLoading.value
                  ?MovieShrimmerLoader()
                  : MovieList(movies: homeController.topMovies)),

              SectionTitle(title: "Actors/Artist"),
              ActorList(),
              SectionTitle(title: "Tv Series"),
              Obx(()=> homeController.isLoading.value
                  ?MovieShrimmerLoader()
                  : TvSeriesMovieList(tvSeries: tvSeriesController.tvSeries)),
              SectionTitle(title: "Sports"),
              //MovieList(movies: movieController.latestMovies ),

              SizedBox(height: 10,),



              SectionTitle(title: "Languages"),
              AudioSelection(),
              SizedBox(height: 10,),

              SectionTitle(title: "New Arrival"),
              // MovieList(movies: movieController.trendingMovies ),

              SectionTitle(title: "Genre"),
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

