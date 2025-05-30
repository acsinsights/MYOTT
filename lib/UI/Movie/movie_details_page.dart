import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_colors.dart';
import 'package:myott/Core/Utils/app_common.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Actors/ActorsDetailedScreen.dart';

import 'package:myott/UI/Components/custom_button.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/UI/Movie/Model/movie_details_model.dart';
import 'package:myott/UI/Profile/Controller/ProfileController.dart';
import 'package:myott/UI/Setting/Setting_Controller.dart';
import 'package:myott/video_player/component/Video_player_page.dart';
import 'package:myott/video_player/component/verticalPlayerPage.dart';
import '../Components/Comment_section.dart';
import '../Components/buildAccessButton.dart';
import '../Director/DirectorDetailedScreen.dart';
import 'Component/ExpandableDescription.dart';
import 'Component/RatingBottomSheet.dart';

class MovieDetailsPage extends StatefulWidget {


  const MovieDetailsPage({super.key});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}


class _MovieDetailsPageState extends State<MovieDetailsPage> {

  final MovieController movieController = Get.put(MovieController());
  final ProfileController profileController = Get.put(ProfileController());
  final SettingController settiingController = Get.put(SettingController());


  @override
  void initState() {
    final slug = Get.arguments['slug'];
    movieController.fetchMovieDetails(slug);
    movieController.checkWishlistStatus(slug);
    profileController.fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          if (movieController.isLoading.value ||
              profileController.isLoading.value ||
              settiingController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (movieController.movieDetails.value == null) {
            return Center(
                child: Text(
                  "No movie details available",
                  style: AppTextStyles.SubHeading2,
                ));
          }
          final movie = movieController.movieDetails.value;
          // final verticalPlayer = settiingController.settingData!.value!.generalSettings.view;
          final verticalPlayer = 1;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MovieBanner(),
                ExpandableDescription(
                  description: movie!.movie.description,
                ),
                SizedBox(
                  height: 10.h,
                ),
                MoviesActionButtons(
                    movieController: movieController, movie: movie),
                SizedBox(
                  height: 10.h,
                ),
                // ActorListWidget(actors: movie.movie.actors,label: "Artist",type: "actor",),
                // ActorListWidget(actors: movie.movie.directors,label: "Directors",type: "director",),


                SizedBox(
                  height: 20.h,
                ),

                CommentSection(
                  comments: movie.comment,
                  controller: movieController.commentController,
                  onSend: () {
                    movieController.addCommentForMovie(
                        movie.movie.id, movie.movie.slug);
                  },
                  onDelete: (comment) {
                    movieController.deleteCommentForMovie(
                        comment.id, movie.movie.slug);
                  },
                  currentUserId: profileController.user.value!.id ??
                      0, // ✅ Pass logged-in user ID
                )


              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<MovieController>();
    super.dispose(); // 🛑 This line is mandatory!

  }
}

class MovieBanner extends StatelessWidget {
  MovieBanner({super.key});

  final MovieController controller = Get.find<MovieController>();

  bool _checkHasAccess(MOrder? order, String contentType) {
    contentType = contentType.trim();

    if (contentType == "subsriptionSystem" || contentType == "pricingSection") {
      return order != null && order.endDate != null &&
          order.endDate!.isAfter(DateTime.now());
    }

    if (contentType == "coinCostSection") {
      return order != null; // Only return true if order is created
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final movie = controller.movieDetails.value;
      final MOrder? order = controller.movieOrder.value;

      if (movie == null) {
        return SizedBox.shrink(); // or a loading indicator
      }

      print("🔥 DEBUG VALUES 🔥");
      print("🎬 isFree: ${movie.movie.packages.free}");
      print("📦 selection: ${movie.movie.packages.selection}");
      print("🔐 hasAccess: ${_checkHasAccess(order, movie.movie.packages.selection)}");

      if (order != null) {
        print("📦 Orders Count: 1");
        print("📄 Order ID: ${order.orderId}");
        print("🗓️ Start: ${order.startDate} - End: ${order.endDate}");
        print("✅ Is Active: ${order.endDate.isAfter(DateTime.now())}");
      } else {
        print("❌ No Order Found");
      }

      return Container(
        height: 400.h,
        child: Stack(
          children: [
            Positioned.fill(
              child: Stack(
                children: [
                  NetworkImageWidget(
                    imageUrl: movie.movie.thumbnailImg,
                    width: double.infinity,
                    height: 400.h,
                    fit: BoxFit.cover,
                    errorAsset: "assets/images/movies/SliderMovies/movie-1.png",
                  ),
                  Container(
                    width: double.infinity,
                    height: 400.h,
                    color: AppColors.black.withOpacity(0.7),
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
                  color: AppColors.white,
                ),
              ),
            ),
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
                        errorAsset: "assets/images/movies/SliderMovies/movie-1.png",
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Container(
                    width: 200.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          movie.movie.name,
                          style: AppTextStyles.Headingb4,
                          maxLines: 2,
                        ),
                        Row(
                          children: [
                            Text(
                              movie.movie.releaseYear,
                              style: AppTextStyles.SubHeadingb3,
                            ),
                            SizedBox(width: 10.w),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                movie.movie.maturity,
                                style: AppTextStyles.SubHeadingb3.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            movie.movie.packages.free
                                ? SizedBox.shrink()
                                : Icon(
                              Icons.workspace_premium,
                              color: Colors.amber,
                              size: 25.w,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        ContentAccessButton(
                          coinPrice: movie.movie.packages.coinCost,
                          slug: movie.movie.slug,
                          isFree: movie.movie.packages.free,
                          selection: movie.movie.packages.selection.toString(),
                          hasAccess: _checkHasAccess(order, movie.movie.packages.selection.toString()),
                          videoUrl: movie.movie.movieUploadUrl,
                          subtitles: movie.movie.subtitles,
                          contentId: movie.movie.id,
                          contentCost: movie.movie.packages.coinCost,
                          contentType: MediaType.movie.name,
                          planPrice: movie.movie.packages.planPrice,
                          offerPrice: movie.movie.packages.offerPrice,
                        ),
                        SizedBox(height: 10.h),
                        CustomButton(
                          width: 180.w,
                          text: "Trailer",
                          onPressed: () {
                            Get.to(VideoPlayerPage(
                              videoUrl: movie.movie.trailerUrl,
                              subtitles: movie.movie.subtitles,
                              dubbedLanguages: {},
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
        ),
      );
    });
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
          onTap: () {
            movieController.toggleWishlist(movie!.movie.id, "M");
          },
          child: Column(
            children: [
              Obx(() =>
                  Icon(
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
          onTap: () {
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
          onTap: () {
            movieController.shareContent(
                movie!.movie.name, "Movie", movie!.movie.movieUploadUrl);
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
      ],
    );
  }
}

class ActorListWidget extends StatelessWidget {
  final List<Ctor> actors; // Ctor used for both Actor and Director
  final String label;
  final String type; // 'actor' or 'director'

  const ActorListWidget({
    super.key,
    required this.actors,
    required this.label,
    required this.type,
  });

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
                    if (type == "actor") {
                      Get.to(() => const ActorsDetailedScreen(), arguments: {
                        "slug": actor.slug,
                      });
                    } else if (type == "director") {
                      Get.to(() => const DirectorDetailedScreen(), arguments: {
                        "slug": actor.slug,
                      });
                    }
                  },
                  child: Column(
                    children: [
                      ClipOval(
                        child: NetworkImageWidget(
                          height: 65.h,
                          width: 65.w,
                          imageUrl: actor.image,
                          errorAsset: "assets/Avtars/person2.png",
                        ),
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
