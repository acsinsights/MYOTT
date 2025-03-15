import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Actors/Controller/ActorController.dart';
import 'package:myott/UI/Actors/Model/ActorsModel.dart';
import 'package:myott/UI/Components/MovieListShrimerLoad.dart';
import 'package:myott/UI/Components/Movie_grid.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import 'package:myott/services/ActorService.dart';
import 'package:myott/services/api_service.dart';

import '../../services/MovieService.dart';
import '../Movie/Controller/Movie_controller.dart';
import '../Movie/Movie_details_page.dart';

class ActorsDetailedScreen extends StatelessWidget {
  final ActorsModel actors;
  const ActorsDetailedScreen({Key? key, required this.actors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ActorController actorController = Get.put(ActorController(ActorSerivce(ApiService()), actors.id));

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: NestedScrollView(
          controller: actorController.scrollController, // ✅ Attach scroll controller
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                foregroundColor: Colors.white,
                expandedHeight: 400.0,
                floating: false,
                pinned: true,
                backgroundColor: Colors.black,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Obx(() => actorController.showTitle.value
                    ? Text(actors.name, style: AppTextStyles.SubHeadingb2)
                    : SizedBox.shrink()), // ✅ Show title only when scrolled
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        actors.image,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 16,
                        right: 16,
                        child: Text(
                          actors.name,
                          style: AppTextStyles.SubHeadingb2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(actors.description.toString(), style: AppTextStyles.SubHeading2),
                SizedBox(height: 10,),
                Text(
                  "Movies of ${actors.name}",
                  style: AppTextStyles.SubHeadingb2,
                ),
                Divider(color: Colors.grey, thickness: 1),
                Obx(() {
                  final actorData = actorController.actorData.value;

                  if (actorController.isLoading.value) {
                    return MovieShrimmerLoader();
                  }

                  if (actorData == null) {
                    return Center(child: Text("Failed to load data", style: AppTextStyles.SubHeading2));
                  }

                  if (actorData.movies.isEmpty) {
                    return Center(child: Text("No movies available", style: AppTextStyles.SubHeading2));
                  }

                  return  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 3 columns like in the image
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.5, // Adjust for movie poster aspect ratio
                      ),
                      itemCount: actorController.actorData.value!.movies.length,
                      itemBuilder: (context, index) {
                        final movie = actorController.actorData.value!.movies[index];

                        return GestureDetector(
                          onTap: () {
                            final movieId = movie.id;
                            Get.to(() => MovieDetailsPage(movieId: movieId),
                                binding: BindingsBuilder(() {
                                  Get.put(MovieController(MoviesService(ApiService())));
                                }));
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 150.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  image: DecorationImage(
                                    image: NetworkImage(movie.posterImg), // Use NetworkImage if from API
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: Text(
                                  movie.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),
                SizedBox(height: 10,),
                Text(
                  "TvSeries of ${actors.name}",
                  style: AppTextStyles.SubHeadingb2,
                ),
                Divider(color: Colors.grey, thickness: 1),
                Obx(() {
                  final actorData = actorController.actorData.value;

                  if (actorController.isLoading.value) {
                    return MovieShrimmerLoader();
                  }

                  if (actorData == null) {
                    return Center(child: Text("Failed to load data", style: AppTextStyles.SubHeading2));
                  }

                  if (actorData.tvSeries.isEmpty) {
                    return Center(child: Text("No TVSeries available", style: AppTextStyles.SubHeading2));
                  }

                  return  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 3 columns like in the image
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.5, // Adjust for movie poster aspect ratio
                      ),
                      itemCount: actorController.actorData.value!.tvSeries.length,
                      itemBuilder: (context, index) {
                        final series = actorController.actorData.value!.tvSeries[index];

                        return GestureDetector(
                          onTap: () {
                            final seriesId = series.id;
                            Get.to(() => TvSeriesDetailsPage(seriesId: seriesId),
                                binding: BindingsBuilder(() {
                                  Get.put(MovieController(MoviesService(ApiService())));
                                }));
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 150.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  image: DecorationImage(
                                    image: NetworkImage(series.thumbnailImg), // Use NetworkImage if from API
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: Text(
                                  series.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}