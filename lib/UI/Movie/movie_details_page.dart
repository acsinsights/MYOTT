import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Actors/ActorsDetailedScreen.dart';
import 'package:myott/UI/Actors/Model/ActorsModel.dart';
import 'package:myott/UI/Components/custom_button.dart';
import 'package:myott/UI/Components/custom_text_field.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/UI/Movie/Model/movie_details_model.dart';
import 'package:myott/video_player/component/Video_player_page.dart';
import 'Component/ExpandableDescription.dart';
import 'Component/RatingBottomSheet.dart';

class MovieDetailsPage extends StatefulWidget {


  const MovieDetailsPage({super.key});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final MovieController movieController =
  Get.put(MovieController());


  @override
  Widget build(BuildContext context) {
    final slug = Get.arguments['slug'];
    movieController.fetchMovieDetails(slug);
    movieController.checkWishlistStatus(slug);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Obx(() {
          if (movieController.isLoading.value) {
            return Center(child: CircularProgressIndicator(color: Colors.white,));
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
                MovieBanner(movie: movie),
                ExpandableDescription(
                  description: movie!.movie.description,
                ),
                SizedBox(
                  height: 10.h,
                ),
                MoviesActionButtons(movieController: movieController, movie: movie),
                SizedBox(
                  height: 10.h,
                ),
                ActorListWidget(actors: movie.movie.actors,label: "Artist",),
                ActorListWidget(actors: movie.movie.directors,label: "Directors",),


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
                SizedBox(
                  height: 200,
                  child: movie.comment.isNotEmpty
                      ? ListView.builder(
                    itemCount: movie.comment.length,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final comment = movie.comment[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border:  Border.all(
                              color: Colors.white
                            )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.name,
                                style: AppTextStyles.SubHeading2,
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                comment.comment,
                                style: AppTextStyles.SubHeadingGrey2,
                              ),
                              SizedBox(height: 5.h),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                      : Center(
                    child: Text(
                      "No comments available",
                      style: AppTextStyles.SubHeadingGrey2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomTextField(
                    controller: movieController.commentController,
                    hintText: "Write a comment",
                    keyboardType: TextInputType.multiline,
                  maxLines: 2,
                    suffixIcon: IconButton(onPressed: (){
                      movieController.addCommentForMovie(movie.movie.id,movie.movie.slug);

                    },
                        icon: Icon(Icons.send,color: Colors.grey,)),
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

class MovieBanner extends StatelessWidget {
  const MovieBanner({
    super.key,
    required this.movie,
  });

  final MovieDetailsModel? movie;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        imageUrl: movie!.movie.posterImg,
                        fit: BoxFit.cover,
                        width: 140.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Container(
                    width: 200.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          movie!.movie.name,
                          style: AppTextStyles.Headingb4,
                          maxLines: 2,
                        ),
                        Row(
                          children: [
                            Text(
                              movie!.movie.releaseYear, // Release Year
                              style: AppTextStyles.SubHeadingb3,
                            ),
                            SizedBox(width: 10.w), // Space between year and maturity
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                movie!.movie.maturity, // Maturity Rating
                                style: AppTextStyles.SubHeadingb3.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        CustomButton(
                          width: 180.w,
                          text: "Play Now",
                          onPressed: () {
                            Get.to(
                                VideoPlayerPage(
                              videoUrl: "https://videos.pexels.com/video-files/4620568/4620568-uhd_2732_1440_25fps.mp4",
                              subtitles: movie!.movie.subtitles,
                              dubbedLanguages: movie!.movie.dubbedLanguages,
                            ));
                          },
                          backgroundColor: Color(0xff290b0b),
                          borderColor: Colors.white,
                        ),
                        SizedBox(height: 10.h),
                        CustomButton(
                          width: 180.w,
                          text: "Trailer",
                          onPressed: () {
                            Get.to(VideoPlayerPage(
                              videoUrl: movie!.movie.trailerUrl,
                              subtitles: movie!.movie.subtitles,
                              dubbedLanguages: movie!.movie.dubbedLanguages,
                            ));
                          },
                          backgroundColor: Colors.black,
                          borderColor: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class MoviesActionButtons extends StatelessWidget {
  const MoviesActionButtons({
    super.key,
    required this.movieController,
    required this.movie,
  });

  final MovieController movieController;
  final MovieDetailsModel? movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: (){
            movieController.toggleWishlist(movie!.movie.id, "M");
          },
          child: Column(
            children: [
              Obx(() => Icon(
                movieController.isWishlisted.value
                    ? CupertinoIcons.heart_fill
                    : CupertinoIcons.add,
                color: movieController.isWishlisted.value
                    ? Colors.red
                    : Colors.white,
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
              RatingBottomSheet(movieId: movie!.movie.id, type: "M"),
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
            movieController.shareContent(movie!.movie.name, "Movie", movie!.movie.movieUploadUrl);
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
    );
  }
}


class ActorListWidget extends StatelessWidget {
  final List<Ctor> actors;
  final String label;

  const ActorListWidget({super.key, required this.actors,required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            label,
            style: AppTextStyles.SubHeadingb1,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: actors.length,
            padding: const EdgeInsets.only(left: 16),
            itemBuilder: (context, index) {
              var actor = actors[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: GestureDetector(
                  onTap: () {
                  },
                  child: Column(
                    children: [
                      ClipOval(
                        child: NetworkImageWidget(
                          height: 65.h,
                          width: 65.w,
                          imageUrl: actor.image,
                        errorAsset: "assets/Avtars/person2.png",
                        )
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        actor.name,
                        style: AppTextStyles.SubHeading2,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
