import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Actors/ActorsDetailedScreen.dart';
import 'package:myott/UI/Components/custom_button.dart';
import 'package:myott/UI/Components/custom_text_field.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/services/MovieService.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/video_player/component/Video_player_page.dart';
import 'Component/ExpandableDescription.dart';
import 'Component/RatingBottomSheet.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;
  final String slug;

  const MovieDetailsPage({super.key, required this.movieId, required this.slug});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final MovieController movieController =
  Get.put(MovieController(MoviesService(ApiService())));
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      movieController.fetchMovieDetails(widget.movieId,widget.slug);
    });

  }


  @override
  Widget build(BuildContext context) {

    movieController.fetchMovieDetails(widget.movieId,widget.slug);

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
                // InlineVideoPlayer(videoUrl: movie!.movie.movieUploadUrl),
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
                                Container(
                                  width: 200.w,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
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
                                          // final vurl="https://videos.pexels.com/video-files/4620568/4620568-uhd_2732_1440_25fps.mp4";

                                          Get.to(VideoPlayerPage(
                                              videoUrl: movie.movie
                                                  .movieUploadUrl,
                                              subtitles: movie.movie.subtitles,
                                              dubbedLanguages: movie.movie
                                                  .dubbedLanguages));
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
                                        onPressed: () {
                                          Get.to(VideoPlayerPage(
                                            videoUrl: movie.movie.trailerUrl,
                                            subtitles: movie.movie.subtitles,
                                            dubbedLanguages: movie.movie
                                                .dubbedLanguages,));
                                        },
                                        backgroundColor: Colors.black,
                                        borderColor: Colors.white,
                                      )
                                    ],
                                  ),
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
                    GestureDetector(
                      onTap: (){
                        movieController.toggleWishlist(movie.movie.id, "M");
                      },
                      child: Column(
                        children: [
                          Obx(() => Icon(
                            movieController.isWishlisted.value
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.add,
                            color: movieController.isWishlisted.value
                                ? Colors.red // Change color when wishlisted
                                : Colors.white, // Default color
                          )),

                          SizedBox(height: 10),
                          Obx(() =>
                              Text(
                                movieController.isWishlisted.value
                                    ? "Wishlisted"
                                    : "WishList",
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        movieController.toggleRate();
                        Get.bottomSheet(
                          RatingBottomSheet(movieId: movie.movie.id, type: "M"),
                          isScrollControlled: true,
                        );
                      },
                      child: Column(
                        children: [
                          Obx(() =>
                              Icon(
                                movieController.isRated.value
                                    ? CupertinoIcons.star_fill
                                    : CupertinoIcons.star,
                                color: Colors.white,
                              )),
                          SizedBox(height: 10),
                          Obx(() =>
                              Text(
                                movieController.isRated.value
                                    ? "Rated"
                                    : "Rate",
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        movieController.shareContent(movie.movie.name, "Movie", movie.movie.movieUploadUrl);
                      },
                      child: Column(
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
                    ),
                    GestureDetector(
                      onTap: () {
                        movieController.toggleDownload();
                      },
                      child: Column(
                        children: [
                          Obx(() {
                            return Icon(
                              movieController.isDownloaded.value
                                  ? Icons.download_done : Icons.download,
                              color: Colors.white,
                            );
                          }),
                          SizedBox(
                            height: 10.h,
                          ),
                          Obx(() {
                            return Text(
                              movieController.isDownloaded.value
                                  ? "Downloaded" : "Download",
                              style: AppTextStyles.SubHeadingb3,
                            );
                          })
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Artist",
                    style: AppTextStyles.SubHeadingb1,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
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
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ActorsDetailedScreen(actors: actor));
                          },
                          child: Column(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  actor.image,
                                  width:
                                  70, // Explicitly setting width and height
                                  height: 70,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error,
                                        color:
                                        Colors.red); // Placeholder on error
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                actor.name,
                                style: AppTextStyles.SubHeading2,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Directors",
                    style: AppTextStyles.SubHeadingb1,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
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
                            ClipOval(
                              child: Image.network(
                                director.image,
                                width:
                                70, // Explicitly setting width and height
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.error,
                                      color:
                                      Colors.red); // Placeholder on error
                                },
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              director.name,
                              style: AppTextStyles.SubHeading2,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Comments",
                    style: AppTextStyles.SubHeadingb1,
                  ),
                ),
                // SizedBox(height: 10.h,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Devendra Bharambe",
                              style: AppTextStyles.SubHeading2,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "I already watched this movie but the movie is awesome and having a fantastic darama.Hero is so cool and one of my favourite person.",
                              style: AppTextStyles.SubHeadingGrey2,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1.h,
                        color: CupertinoColors.white,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Devendra Bharambe",
                              style: AppTextStyles.SubHeading2,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "I already watched this movie but the movie is awesome and having a fantastic darama.Hero is so cool and one of my favourite person.",
                              style: AppTextStyles.SubHeadingGrey2,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CustomTextField(
                    maxLines: 2,
                    keyboardType: TextInputType.multiline,
                    controller: movieController.commentController,
                    hintText: "Enter Your Comment",
                    suffixIcon:
                    IconButton(onPressed: () {
                      movieController.addCommentForMovie(movieController.commentController.value.text, movie.movie.id);

                    }, icon: Icon(Icons.send)),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
