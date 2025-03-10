

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Components/custom_button.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/UI/Components/section_title.dart';
import 'package:myott/UI/Home/Component/actor_list.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/UI/Movie/Movie_details_page.dart';
import 'package:myott/services/MovieService.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/video_player/component/Video_palyer_widget.dart';
import 'package:video_player/video_player.dart';

import '../../video_player/component/universalVideoPlayer.dart';
import 'Component/ExpandableDescription.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;
  const MovieDetailsPage({super.key, required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final MovieController movieController =
        Get.put(MovieController(MoviesService(ApiService())));
    movieController.fetchMovieDetails(widget.movieId);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Obx(() {
          if (movieController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (movieController.movieDetails.value == null) {
            return Center(
                child: Text(
              "No movie details available",
              style: AppTextStyles.SubHeading2,
            ));
          }
          final movie = movieController.movieDetails.value;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 400.h,
                    child: Stack(
                      children: [

                        Positioned.fill(
                          child: Stack(
                            children: [
                              NetworkImageWidget(
                                imageUrl: movie!.movie.thumbnailImg,
                                width: double.infinity,
                                height: 400.h,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                width: double.infinity,
                                height: 400.h,
                                color: Colors.black.withOpacity(
                                    0.7), // Black overlay with 50% opacity
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            top: 10,
                            left: 10,
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ))),
                        Positioned(
                            bottom: 20,
                            left: 10,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 200.h,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: NetworkImageWidget(
                                      imageUrl: movie.movie.posterImg,
                                      fit: BoxFit.cover,
                                      width: 140.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      movie.movie.name,
                                      style: AppTextStyles.Headingb4,
                                      maxLines: 2,
                                    ),
                                    Text(
                                      movie.movie.releaseYear,
                                      style: AppTextStyles.SubHeadingb3,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CustomButton(
                                      width: 180.w,
                                      text: "Play Now",
                                      onPressed: () {
                                        Get.to(UniversalVideoPlayer(videoUrl: movie.movie.trailerUrl)
                                        );

                                      },
                                      backgroundColor: Color(0xff290b0b),
                                      borderColor: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CustomButton(
                                      width: 180.w,
                                      text: "Trailer",
                                      onPressed: () {},
                                      backgroundColor: Colors.black,
                                      borderColor: Colors.white,
                                    )
                                  ],
                                )
                              ],
                            ))
                      ],
                    )),
                ExpandableDescription(
                  description: movie.movie.description,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(
                          CupertinoIcons.add,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "WishList",
                          style: AppTextStyles.SubHeadingb3,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          CupertinoIcons.star,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Rate",
                          style: AppTextStyles.SubHeadingb3,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Share",
                          style: AppTextStyles.SubHeadingb3,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.download,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Download",
                          style: AppTextStyles.SubHeadingb3,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Artist",
                    style: AppTextStyles.SubHeadingb1,
                  ),
                ),
                SizedBox(height: 10.h,),
                SizedBox(
                  height: 100.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movie.movie.actors.length,
                    padding: const EdgeInsets.only(left: 16),
                    itemBuilder: (context, index) {
                      var actor = movie.movie.actors[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  NetworkImage(actor.image), // Removed `const`
                            ),
                            SizedBox(height: 5.h,),
                            Text(actor.name,style: AppTextStyles.SubHeading2,)
                          ],
                        ),
            
                      );
                    },
                  ),
                ),
                SizedBox(height: 10.h,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Directors",
                    style: AppTextStyles.SubHeadingb1,
                  ),
                ),
                SizedBox(height: 10.h,),
                SizedBox(
                  height: 100.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movie.movie.directors.length,
                    padding: const EdgeInsets.only(left: 16),
                    itemBuilder: (context, index) {
                      var director = movie.movie.directors[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage:
                              NetworkImage(director.image), // Removed `const`
                            ),
                            SizedBox(height: 5.h,),
                            Text(director.name,style: AppTextStyles.SubHeading2,)
                          ],
                        ),
            
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h,)
              ],
            ),
          );
        }),
      ),
    );
  }
}


