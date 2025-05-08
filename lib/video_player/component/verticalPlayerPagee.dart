import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/UI/WatchHistory/Controller/watchHistoryController.dart';
import 'package:video_player/video_player.dart';
import '../../UI/TvSeries/Controller/tv_series_controller.dart';
import '../Controller/VerticalPlayerControllerr.dart';

class VerticalPlayerPagee extends StatefulWidget {
  @override
  State<VerticalPlayerPagee> createState() => _VerticalPlayerPageeState();
}

class _VerticalPlayerPageeState extends State<VerticalPlayerPagee> {
  final VerticalPlayerControllerr controller = Get.put(VerticalPlayerControllerr());
  final TVSeriesController tvSeriesController = Get.put(TVSeriesController());
  final WatchHistoryController watchHistoryController = Get.put(WatchHistoryController());
  late PageController pageController;


  @override
  void initState() {
    super.initState();
    final slug = Get.arguments['slug'];
    final contentId = Get.arguments['contentId'];

    if (slug != null) {
      controller.isLoading.value = true;
      pageController = PageController();


      tvSeriesController.fetchTVSeriesDetails(slug).then((_) {
        // Fetch the episodes and safely handle the nullable SOrder
        controller.seriesDetails.value = tvSeriesController.tvSeriesDetails.value;
        final order = tvSeriesController.torder.value;

        controller.loadEpisodes(
          tvSeriesController.episodes,
          order, // This can be null
          tvSeriesController.tvSeriesDetails.value!.series.seriesPackage,
        );

      });
    }
    if (contentId != null) {
      watchHistoryController.addHistory("S", contentId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        return PageView.builder(
          controller: pageController,
          scrollDirection: Axis.vertical,
          onPageChanged: controller.onPageChanged,
          itemCount: controller.episodes.length,
          itemBuilder: (context, index) {
            return GetBuilder<VerticalPlayerControllerr>(builder: (_) {
              final videoCtrl = controller.videoController;

              if (index != controller.currentIndex.value) {
                print("this is not the current index");
                return const Center(child: CircularProgressIndicator());
              }

              if (videoCtrl == null || !videoCtrl.value.isInitialized) {
                print("Video controller is not initialized");
                return const Center(child: CircularProgressIndicator());
              }

              return Stack(
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: videoCtrl.value.aspectRatio,
                      child: VideoPlayer(videoCtrl),
                    ),
                  ),

                  Positioned(
                    bottom: 30.h,
                    left: 0,
                    right: 0,
                    child: Obx(() {
                      if (!controller.isInitialized.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.w,
                          ),
                        );
                      }

                      final index = controller.currentIndex.value;
                      final videoController = controller.videoController!;

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Episode Title
                            Text(
                              "EP ${controller.episodes[index].episodeNumber}: ${controller.episodes[index].title}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            // Progress Bar
                            ValueListenableBuilder(
                              valueListenable: videoController,
                              builder: (context, VideoPlayerValue value, child) {
                                return Row(
                                  children: [
                                    // Current position
                                    Text(
                                      _formatDuration(value.position),
                                      style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                                    ),
                                    SizedBox(width: 8.w),
                                    // Progress bar
                                    Expanded(
                                      child: SliderTheme(
                                        data: SliderThemeData(
                                          trackHeight: 4.h,
                                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.r),
                                          overlayShape: RoundSliderOverlayShape(overlayRadius: 12.r),
                                        ),
                                        child: Slider(
                                          value: value.position.inMilliseconds.toDouble(),
                                          min: 0,
                                          max: value.duration.inMilliseconds.toDouble(),
                                          activeColor: Colors.red,
                                          inactiveColor: Colors.white24,
                                          onChanged: (newValue) {
                                            videoController.seekTo(Duration(milliseconds: newValue.toInt()));
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    // Total duration
                                    Text(
                                      _formatDuration(value.duration),
                                      style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  Positioned(
                    right: 16.w,
                    bottom: 100.h,
                    child: Column(
                      children: [
                        _buildActionButton(
                          Icons.playlist_play_rounded,
                          "Episodes",
                            (){
                              _showEpisodesBottomSheet(context, controller);
                            }
                        ),
                        SizedBox(height: 16.h),
                        _buildActionButton(
                          Icons.share,
                          "Share",
                              () {},
                        ),
                      ],
                    ),
                  ),

                ],
              );
            });
          },
        );
      }),
    );
  }
  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.black38,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  void _showEpisodesBottomSheet(BuildContext context, VerticalPlayerControllerr controller) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Episodes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white70),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              height: 300.h,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 1.2,
                ),
                itemCount: controller.episodes.length,
                itemBuilder: (context, index) {
                  final episode = controller.episodes[index];
                  final bool isFree = episode.isFree??false;
                  final bool hasAccess = isFree || controller.checkHasAccess();

                  return InkWell(
                    onTap: () {
                      Get.back();
                      if (hasAccess) {
                        pageController.jumpToPage(index); // 👈 Visually jump
                        controller.onPageChanged(index);
                      } else {
                        // Show dialog or navigate to subscription screen
                        Get.snackbar("Access Denied", "Please purchase the series to unlock this episode",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: controller.currentIndex.value == index
                            ? Colors.red.withOpacity(0.3)
                            : Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${episode.episodeNumber}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "Episode",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!hasAccess)
                            Positioned(
                              top: 4.h,
                              right: 4.w,
                              child: Icon(
                                Icons.lock,
                                color: Colors.white70,
                                size: 16.sp,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

}
