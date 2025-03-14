import 'package:flutter/material.dart';
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
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/UI/TvSeries/Controller/tv_series_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

              SectionTitle(
                title: "latestRelease".tr,
                onTap: () {
                  Get.to(
                    MovieGrid(
                      movies: homeController.homePageData.value!.latest, // Correct way to pass list
                      title: "latestRelease".tr,
                    ),
                  );
                },
              ),
              Obx(() {
                if (homeController.isLoading.value) {
                  return MovieShrimmerLoader();
                }
                return MovieList(movies: homeController.homePageData.value!.latest);
              }),

              SizedBox(height: 10),


              SectionTitle(title: "Top10".tr,onTap: (){
                Get.to(MovieGrid(movies: homeController.homePageData.value!.top10,title: "Top10".tr,));
              },),
              Obx(() => homeController.isLoading.value
                  ? MovieShrimmerLoader()
                  : MovieList(movies: homeController.homePageData.value!.top10.take(10).toList(), isTop10: true)),

              SectionTitle(title: "Actors".tr,showAll: false),
              ActorList(),


              SectionTitle(title: "TvSeries".tr,onTap: (){
                Get.to(TvSeriesGird(tvSeries: tvSeriesController.tvSeries,title: "TvSeries".tr,));
              }),
              Obx(()=> homeController.isLoading.value
                  ?MovieShrimmerLoader()
                  : TvSeriesMovieList(tvSeries: tvSeriesController.tvSeries)),

              SizedBox(height: 10,),



              SectionTitle(title: "Languages".tr,showAll: false,),
              AudioSelection(),
              SizedBox(height: 10,),

              SectionTitle(title: "NewArrival".tr,onTap: () async{
                SharedPreferences pref= await SharedPreferences.getInstance();
                print(pref.getString("access_token"));
                Get.to(MovieGrid(movies: homeController.homePageData.value!.newArrival,title: "NewArrival".tr,));
              },),
              Obx(()=> homeController.isLoading.value
                  ?MovieShrimmerLoader()
                  : MovieList(movies: homeController.homePageData.value!.newArrival ),
              ),

              SectionTitle(title: "Genre".tr,showAll: false,),
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

