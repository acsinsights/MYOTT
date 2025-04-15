import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/UI/Home/Controller/themeController.dart';
import 'package:myott/UI/Setting/Wallet/wallet_Screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Core/Utils/app_colors.dart';
import '../../Core/Utils/app_common.dart';
import '../../Core/Utils/app_text_styles.dart';
import '../Actors/Components/actor_list.dart';
import '../Components/MovieListShrimerLoad.dart';
import '../Components/Movie_grid.dart';
import '../Components/ShimmerLoader.dart';
import '../Components/TvSeriesGrid.dart';
import '../Components/VideoList.dart';
import '../Components/movie_list.dart';
import '../Components/section_title.dart';
import '../Genre/components/Gnere_selection.dart';
import '../Model/Moviesmodel.dart';
import '../Movie/Model/movie_details_model.dart';
import '../Movie/Movie_details_page.dart';
import '../TvSeries/Component/TvShowList.dart';
import '../TvSeries/Controller/tv_series_controller.dart';
import '../TvSeries/Model/TVSeriesDetailsModel.dart';
import '../TvSeries/TvSeries_details_page.dart';
import '../Video/video_Detials_page.dart';
import 'Component/Audio_selection.dart';
import 'Component/coming_soon_widget.dart';
import 'Component/latest_movie_list.dart';
import 'Controller/Home_controller.dart';
import 'Controller/MovieSliderController.dart';
import 'Model/latestMandTModel.dart';
import 'Model/seriesModel.dart';
import 'Model/videoModel.dart';

class Dramaboxhomescreen extends StatefulWidget {
  const Dramaboxhomescreen({super.key});

  @override
  State<Dramaboxhomescreen> createState() => _DramaboxhomescreenState();
}

class _DramaboxhomescreenState extends State<Dramaboxhomescreen> {
  final homeController = Get.put(HomeController());
  ThemeController controller=Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 500.h, // adjust height as needed
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.redAccent.withOpacity(0.35),
                    Colors.transparent,
                  ],
                  center: Alignment.topCenter,
                  radius: 1.0,
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Obx(() {
                final homeData = homeController.homePageData.value;

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

                if (homeData == null) {
                  return Center(
                    child: Text(
                      "No data available",
                      style: TextStyle(color: AppColors.text),
                    ),
                  );
                }
                return Column(
                  children: [
                    SizedBox(height: 50.h),
                    MovieSlider(),

                    if (homeData.latest.movies.isNotEmpty || homeData.latest.series.isNotEmpty) ...[
                      SectionTitle(title: "Latest".tr, showAll: false),
                      LatestDramaMandSList(movies: homeData.latest.movies, series: homeData.latest.series)
                    ],
                    if (homeData.top10.isNotEmpty) ...[
                      SectionTitle(
                        title: "Top 10".tr,
                        onTap: () => Get.to(MovieGrid(
                          movies: homeData.top10,
                          title: "Top 10".tr,
                        )),
                      ),
                      DramaMovieList(movies: homeData.top10.take(10).toList(), isTop10: true),
                    ],
                    // ActorList(),
                    if (homeData.series.isNotEmpty) ...[
                      SectionTitle(
                        title: "TV Series".tr,
                        onTap: () => Get.to(TvSeriesGrid(
                          tvSeries: homeData.series,
                          title: "TV Series".tr,
                        )),
                      ),
                      RoundedTvSeriesList(tvSeries: homeData.series),
                    ],
                    if (homeData.audios.isNotEmpty) ...[
                      SectionTitle(title: "Languages".tr, showAll: false),
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
                      SectionTitle(title: "Videos".tr, showAll: false),
                      RoundedVideoList(videos: homeData.video),
                    ],
                    if (homeData.genre.isNotEmpty) ...[
                      SectionTitle(title: "Genre".tr, showAll: false),
                      GenreSelection(),
                    ],
                    const SizedBox(height: 20),
                    // ComingSoonWidget(),
                  ],
                );
              }),
            ),
          ),
// Glowing reddish effect at top

          // 🎁 Gift Icon Positioned at Top Right
          Positioned(
            top: 35.h,
            right: 16,
            child: GestureDetector(
              onTap: () {
                Get.to(WalletScreen());
                // Handle gift icon tap here
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/Icons/gift-box.png',
                  width: 28,
                  height: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
class RoundedVideoList extends StatelessWidget {
  final List<Video> videos;
  final bool isTop10;

  RoundedVideoList({Key? key, required this.videos, this.isTop10 = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "No video available",
            style: AppTextStyles.SubHeading2.copyWith(color: Colors.white),
          ),
        ),
      );
    }

    return SizedBox(
      height: 180.h,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double itemWidth = (constraints.maxWidth - 16 - (2 * 12)) / 3;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: videos.length,
            padding: const EdgeInsets.only(left: 16),
            itemBuilder: (context, index) {
              final video = videos[index];

              return GestureDetector(
                onTap: () {
                  Get.to(VideoDetialsPage(), arguments: {
                    "videoId": video.id,
                    "slug": video.slug
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: itemWidth,
                          height: itemWidth * 1.2,
                          child: NetworkImageWidget(
                            imageUrl: video.image,
                            errorAsset: "assets/images/movies/SliderMovies/movie-1.png",
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: itemWidth,
                        child: Text(
                          video.name,
                          style: AppTextStyles.SubHeading2.copyWith(color: AppColors.text),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class RoundedTvSeriesList extends StatelessWidget {
  final List<HomeSeries> tvSeries;

  RoundedTvSeriesList({Key? key, required this.tvSeries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tvSeries.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "No TV Series available",
            style: AppTextStyles.SubHeading2.copyWith(color: Colors.white),
          ),
        ),
      );
    }

    return SizedBox(
      height: 180.h,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double itemWidth = (constraints.maxWidth - 16 - (2 * 12)) / 3;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tvSeries.length,
            padding: const EdgeInsets.only(left: 16),
            itemBuilder: (context, index) {
              final item = tvSeries[index];

              return GestureDetector(
                onTap: () {
                  Get.to(() => TvSeriesDetailsPage(), arguments: {
                    "slug": item.slug
                  }, binding: BindingsBuilder(() {
                    Get.put(TVSeriesController());
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: itemWidth,
                          height: itemWidth * 1.2,
                          child: Image.network(
                            item.thumbnailImg,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/placeholder.png',
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: itemWidth,
                        child: Text(
                          item.name,
                          style: AppTextStyles.SubHeading2.copyWith(color: Colors.white, fontSize: 12),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class LatestDramaMandSList extends StatelessWidget {
  final List<latestMovie> movies;
  final List<latestSeries> series;

  LatestDramaMandSList({
    Key? key,
    required this.movies,
    required this.series,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MediaItem> latestList = [
      ...movies.map((movie) => MediaItem(
        id: movie.id,
        name: movie.name,
        imageUrl: movie.posterImg,
        slug: movie.slug,
        type: MediaType.movie,
        isfree: movie.package.free,
      )),
      ...series.map((series) => MediaItem(
        id: series.id,
        name: series.name,
        imageUrl: series.thumbnailImg,
        slug: series.slug,
        type: MediaType.series,
        isfree: series.seriesPackage!.free,
      )),
    ];

    if (latestList.isEmpty) {
      return SizedBox();
    }

    return SizedBox(
      height: 180.h,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double itemWidth = (constraints.maxWidth - 16 - (2 * 12)) / 3;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: latestList.length,
            padding: const EdgeInsets.only(left: 16),
            itemBuilder: (context, index) {
              final item = latestList[index];

              return GestureDetector(
                onTap: () {
                  if (item.type == MediaType.movie) {
                    Get.to(() => MovieDetailsPage(), arguments: {
                      "movieId": item.id,
                      "slug": item.slug,
                    });
                  } else if (item.type == MediaType.series) {
                    Get.to(() => TvSeriesDetailsPage(), arguments: {
                      "slug": item.slug,
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: itemWidth,
                          height: itemWidth * 1.2, // maintain poster ratio
                          child: NetworkImageWidget(
                            imageUrl: item.imageUrl,
                            errorAsset: "assets/images/movies/SliderMovies/movie-1.png",
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: itemWidth,
                        child: Text(
                          item.name,
                          style: AppTextStyles.SubHeading2.copyWith(color: AppColors.text),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DramaMovieList extends StatelessWidget {
  final List<MoviesModel> movies;
  final bool isTop10;

  DramaMovieList({Key? key, required this.movies, this.isTop10 = false}) : super(key: key);

  final List<String> topRankImages = [
    'assets/Icons/top_10_icon/ic_one.png',
    'assets/Icons/top_10_icon/ic_two.png',
    'assets/Icons/top_10_icon/ic_three.png',
    'assets/Icons/top_10_icon/ic_four.png',
    'assets/Icons/top_10_icon/ic_five.png',
    'assets/Icons/top_10_icon/ic_six.png',
    'assets/Icons/top_10_icon/ic_seven.png',
    'assets/Icons/top_10_icon/ic_eight.png',
    'assets/Icons/top_10_icon/ic_nine.png',
    'assets/Icons/top_10_icon/ic_ten.png',
  ];

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "No movies available",
            style: AppTextStyles.SubHeading2.copyWith(color: Colors.white),
          ),
        ),
      );
    }

    return SizedBox(
      height: 180,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double itemWidth = (constraints.maxWidth - 16 - (2 * 12)) / 3;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            padding: const EdgeInsets.only(left: 16),
            itemBuilder: (context, index) {
              final movie = movies[index];
              final bool isFree = movie.package?.free ?? false;

              return GestureDetector(
                onTap: () {
                  final slug = movie.slug;
                  debugPrint(slug);
                  Get.to(() => MovieDetailsPage(), arguments: {'slug': slug});
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: itemWidth,
                              height: itemWidth * 1.25, // maintain poster ratio
                              child: NetworkImageWidget(
                                imageUrl: movie.thumbnailImg,
                                errorAsset: "assets/images/movies/SliderMovies/movie-1.png",
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: itemWidth,
                            child: Text(
                              movie.name,
                              style: AppTextStyles.SubHeading2.copyWith(color: AppColors.text),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      if (isTop10 && index < topRankImages.length)
                        Positioned(
                          bottom: itemWidth * 0.45,
                          right: 6,
                          child: Image.asset(
                            topRankImages[index],
                            width: 30,
                            height: 40,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MovieSlider extends StatelessWidget {
  final movieSliderController = Get.put(MovieSliderController());
  final homeController = Get.put(HomeController());

  MovieSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200.h,
          child: Obx(() {
            final sliderData = homeController.homePageData.value?.slider ?? [];

            if (sliderData.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ShimmerLoader(height: 200.h),
              );
            }

            return CarouselSlider.builder(
              itemCount: sliderData.length,
              itemBuilder: (context, index, realIndex) {
                var movie = sliderData[index];
                final content = movie.content;

                return GestureDetector(
                  onTap: () {
                    switch (content.type?.toLowerCase()) {
                      case 'movie':
                        Get.to(MovieDetailsPage(), arguments: {
                          "slug": content.slug
                        });
                        break;
                      case 'series':
                        Get.to(TvSeriesDetailsPage(), arguments: {
                          "slug": content.slug
                        });
                        break;
                      case 'video':
                        Get.to(VideoDetialsPage(), arguments: {
                          "slug": content.slug
                        });
                        break;
                      default:
                        showSnackbar("Comming Soon", "Future Update");
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          NetworkImageWidget(
                            imageUrl: content.thumbnailImg ?? "",
                            errorAsset: "assets/images/movies/SliderMovies/movie-1.png",
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.black.withOpacity(0.4),
                                    AppColors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 15.h,
                            left: 15.w,
                            child: Container(
                              width: 180.w,
                              child: Text(
                                content.name,
                                style: AppTextStyles.Headingb.copyWith(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 15.h,
                            right: 15.w,
                            child: Obx(() {
                              int currentIndex = movieSliderController
                                  .currentIndex.value;
                              int totalSlides =
                                  homeController.homePageData.value?.slider
                                      .length ?? 0;

                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.h),
                                child: AnimatedSmoothIndicator(
                                  activeIndex: currentIndex.clamp(
                                      0, totalSlides - 1),
                                  count: sliderData.length,
                                  effect: ExpandingDotsEffect(
                                    expansionFactor: 2,
                                    spacing: 6.w,
                                    radius: 4.r,
                                    dotHeight: 6.h,
                                    dotWidth: 12.w,
                                    activeDotColor: Colors.white,
                                    dotColor: Colors.white.withOpacity(0.4),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 200.h,
                autoPlay: true,
                enlargeCenterPage: false,
                viewportFraction: 0.9,
                onPageChanged: (index, reason) {
                  movieSliderController.updatePage(index);
                },
              ),
            );
          }),
        ),

      ],
    );
  }
}

