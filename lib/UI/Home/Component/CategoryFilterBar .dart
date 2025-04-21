import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_colors.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Components/Movie_grid.dart';
import 'package:myott/UI/Components/TvSeriesGrid.dart';
import 'package:myott/UI/Home/Controller/Home_controller.dart';
import 'package:myott/UI/Home/Model/HomePageModel.dart';
import 'package:myott/UI/Model/Moviesmodel.dart';
import '../../Components/network_image_widget.dart';
import '../../Video/video_Detials_page.dart';
import '../Model/videoModel.dart';

class CategoryFilterBar extends StatefulWidget {
  const CategoryFilterBar({Key? key}) : super(key: key);

  @override
  State<CategoryFilterBar> createState() => _CategoryFilterBarState();
}

class _CategoryFilterBarState extends State<CategoryFilterBar> with RouteAware {
  final HomeController homeController = Get.find<HomeController>();
  final RxInt selectedIndex = 0.obs;
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  // Define category labels
  final List<String> categories = [
    'All',
    'Series',
    'Top 10',
    'Latest',
    'Videos'
  ];

  @override
  void initState() {
    super.initState();
    // Reset selectedIndex to 0 when widget is created
    selectedIndex.value = 0;
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final homeData = homeController.homePageData.value;

      // Return empty container if data is not loaded yet
      if (homeData == null) {
        return SizedBox();
      }

      return Container(
        height: 40.h,
        margin: EdgeInsets.only(bottom: 16.h),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemBuilder: (context, index) {
            return Obx(() => GestureDetector(
              onTap: () {
                selectedIndex.value = index;
                _handleCategoryTap(index, homeData);
              },
              child: Container(
                height: 50.h,
                margin: EdgeInsets.only(right: 12.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: selectedIndex.value == index
                      ? Colors.redAccent.withOpacity(0.7)
                      : Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                      color: selectedIndex.value == index
                          ? Colors.redAccent
                          : Colors.white.withOpacity(0.1),
                      width: 1
                  ),
                ),
                child: Text(
                  categories[index].tr,
                  style: AppTextStyles.SubHeading2.copyWith(
                    color: selectedIndex.value == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.7),
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ));
          },
        ),
      );
    });
  }

  void _handleCategoryTap(int index, HomePageModel homeData) {
    switch(categories[index]) {
      case 'All':
      // Stay on the home screen (no navigation needed)
        break;
      case 'Series':
        if (homeData.series.isNotEmpty) {
          Get.to(() => TvSeriesGrid(
            tvSeries: homeData.series,
            title: "TV Series".tr,
          ))?.then((_) {
            // Reset to "All" when returning from grid view
            selectedIndex.value = 0;
          });
        }
        break;
      case 'Top 10':
        if (homeData.top10.isNotEmpty) {
          Get.to(() => MovieGrid(
            movies: homeData.top10,
            title: "Top 10".tr,
          ))?.then((_) {
            // Reset to "All" when returning from grid view
            selectedIndex.value = 0;
          });
        }
        break;
      case 'Latest':
      // Create proper MoviesModel objects from latestMovie objects for the Latest category
        List<MoviesModel> latestMovies = [];

        // Convert latestMovie objects to MoviesModel objects
        if (homeData.latest.movies.isNotEmpty) {
          for (var movie in homeData.latest.movies) {
            latestMovies.add(MoviesModel(
              id: movie.id,
              name: movie.name,
              thumbnailImg: movie.thumbnailImg,
              slug: movie.slug,
              posterImg: movie.posterImg,
              description: "",
              trailerUrl: '',
              releaseYear: '',
              directors: [],
              package: null,
            ));
          }

          if (latestMovies.isNotEmpty) {
            Get.to(() => MovieGrid(
              movies: latestMovies,
              title: "Latest Movies".tr,
            ))?.then((_) {
              // Reset to "All" when returning from grid view
              selectedIndex.value = 0;
            });
          }
        }
        break;
      case 'Videos':
        if (homeData.video.isNotEmpty) {
          Get.to(() => VideoGridView(
            videos: homeData.video,
            title: "Videos".tr,
          ))?.then((_) {
            // Reset to "All" when returning from grid view
            selectedIndex.value = 0;
          });
        }
        break;
    }
  }
}

// VideoGridView implementation
class VideoGridView extends StatelessWidget {
  final List<Video> videos;
  final String title;

  const VideoGridView({
    Key? key,
    required this.videos,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          title,
          style: AppTextStyles.Heading.copyWith(color: AppColors.text),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          // Background gradient effect
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300.h,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.redAccent.withOpacity(0.2),
                    Colors.transparent,
                  ],
                  center: Alignment.topCenter,
                  radius: 1.0,
                ),
              ),
            ),
          ),

          // Grid view of videos
          GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
            ),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];

              return GestureDetector(
                onTap: () {
                  Get.to(() => VideoDetialsPage(), arguments: {
                    "videoId": video.id,
                    "slug": video.slug
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: NetworkImageWidget(
                          imageUrl: video.image,
                          errorAsset: "assets/images/movies/SliderMovies/movie-1.png",
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      video.name,
                      style: AppTextStyles.SubHeading2.copyWith(
                        color: AppColors.text,
                        fontSize: 12.sp,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}