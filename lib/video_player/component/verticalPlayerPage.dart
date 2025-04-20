import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/TvSeries/Model/TVSeriesDetailsModel.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Controller/verticalPlayerController.dart';

class VerticalPlayerPage extends StatelessWidget {
  final List<Episode> episodes;
  final SeriesPackage? seriesPackage;
  final SOrder? order;
  final String? slug;
  final int? contentId;
  final String title;

  const VerticalPlayerPage({
    required this.episodes,
    this.seriesPackage,
    this.order,
    this.slug,
    this.contentId,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerticalPlayerController());

    return FutureBuilder(
      future: controller.initData(episodes, seriesPackage, order, slug,contentId),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: Colors.black,
          body:Stack(
            children: [

              // PageView.builder(
              //   scrollDirection: Axis.vertical,
              //   itemCount: controller.episodes.length,
              //   onPageChanged: controller.onPageChanged,
              //   itemBuilder: (context, index) {
              //     final episode = controller.episodes[index];
              //     final isYouTube = episode.uploadUrl.contains("youtube.com") || episode.uploadUrl.contains("youtu.be");
              //
              //     return GestureDetector(
              //       onTap: () => controller.togglePlayPause(index),
              //       child: Stack(
              //         fit: StackFit.expand,
              //         children: [
              //           if (isYouTube)
              //             YouTubeShortPlayer(url: episode.uploadUrl)
              //           else
              //             Obx(() {
              //               final videoController = controller.controllers[index];
              //               if (videoController.value.isInitialized)
              //                 return FittedBox(
              //                   fit: BoxFit.cover,
              //                   child: SizedBox(
              //                     width: videoController.value.size.width,
              //                     height: videoController.value.size.height,
              //                     child: VideoPlayer(videoController),
              //                   ),
              //                 );
              //               else
              //                 return Center(child: CircularProgressIndicator());
              //             }),
              //
              //           // Play/Pause Icon (shows briefly when tapped)
              //           Obx(() {
              //             final isPlaying = controller.isPlaying(index);
              //             final showIcon = controller.showPlayPauseIcon.value &&
              //                 controller.currentIndex.value == index;
              //
              //             return AnimatedOpacity(
              //               opacity: showIcon ? 1.0 : 0.0,
              //               duration: Duration(milliseconds: 300),
              //               child: Center(
              //                 child: Container(
              //                   padding: EdgeInsets.all(16),
              //                   decoration: BoxDecoration(
              //                     color: Colors.black38,
              //                     shape: BoxShape.circle,
              //                   ),
              //                   child: Icon(
              //                     isPlaying ? Icons.pause : Icons.play_arrow,
              //                     size: 50,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //               ),
              //             );
              //           }),
              //         ],
              //       ),
              //     );
              //   },
              // ),




              PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controller.episodes.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (context, index) {
                  final videoController = controller.controllers[index];
                  final episode = controller.episodes[index];

                  return GestureDetector(
                    onTap: () => controller.togglePlayPause(index),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (videoController.value.isInitialized)
                          FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: videoController.value.size.width,
                              height: videoController.value.size.height,
                              child: VideoPlayer(videoController),
                            ),
                          )
                        else
                          Center(child: CircularProgressIndicator()),

                        // Play/Pause Icon (shows briefly when tapped)
                        Obx(() {
                          final isPlaying = controller.isPlaying(index);
                          final showIcon = controller.showPlayPauseIcon.value &&
                              controller.currentIndex.value == index;

                          return AnimatedOpacity(
                            opacity: showIcon ? 1.0 : 0.0,
                            duration: Duration(milliseconds: 300),
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),

              // Title Bar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black87, Colors.transparent],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Side Action Buttons
              Positioned(
                right: 16.w,
                bottom: 100.h,
                child: Column(
                  children: [
                    // Episodes Button
                    _buildActionButton(
                      Icons.playlist_play_rounded,
                      "Episodes",
                          () => _showEpisodesBottomSheet(context, controller),
                    ),
                    SizedBox(height: 16.h),
                    // Share Button
                    _buildActionButton(
                      Icons.share,
                      "Share",
                          () => _shareContent(controller),
                    ),
                  ],
                ),
              ),

              // Progress Loader
              Positioned(
                bottom: 30.h,
                left: 0,
                right: 0,
                child: Obx(() {
                  final index = controller.currentIndex.value;
                  final videoController = controller.controllers[index];

                  if (!videoController.value.isInitialized) return SizedBox();

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
            ],
          ),
        );
      },
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

  void _showEpisodesBottomSheet(BuildContext context, VerticalPlayerController controller) {
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
                  final bool isFree = episode.isFree;
                  final bool hasAccess = isFree || controller.checkHasAccess();

                  return InkWell(
                    onTap: () {
                      Get.back();
                      if (hasAccess) {
                        controller.currentIndex.value = index;
                        controller.playVideo(index);
                      } else {
                        controller.handlePremiumContent();
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

  void _shareContent(VerticalPlayerController controller) {
    final currentIndex = controller.currentIndex.value;
    final episode = controller.episodes[currentIndex];
    final contentId = controller.contentId ?? 0;

    // Construct a shareable message
    final shareMessage = "Check out Episode ${episode.episodeNumber}: ${episode.title} on MyOTT! ${controller.slug ?? 'app://series/$contentId/episode/${episode.id}'}";

    Share.share(shareMessage);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}