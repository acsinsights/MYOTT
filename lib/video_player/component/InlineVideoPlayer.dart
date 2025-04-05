// import 'package:better_player_plus/better_player_plus.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:myott/video_player/Controller/CustomVideoController.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class Inlinevideoplayer extends StatelessWidget {
//   final String videoUrl;
//   final Map<String, dynamic>? subtitles;
//   final Map<String, dynamic>? dubbedLanguages;
//
//   const Inlinevideoplayer({super.key,required this.videoUrl,
//      this.subtitles,
//      this.dubbedLanguages,});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//         init: CustomVideoPlayerController(videoUrl, subtitles!, dubbedLanguages!),
//         builder: (controller){
//           return Column(
//             children: [
//               AspectRatio(
//                 aspectRatio: 16/9,
//                 child: controller.isYouTube
//                     ? _buildYouTubePlayer(controller)
//                     : _buildBetterPlayer(controller),
//
//               ),
//             ],
//           );
//
//         });
//   }
//   Widget _buildYouTubePlayer(CustomVideoPlayerController controller) {
//     return YoutubePlayerBuilder(
//       player: YoutubePlayer(controller: controller.youtubePlayerController!),
//       builder: (context, player) {
//         return player;
//       },
//     );
//   }
//
//   Widget _buildBetterPlayer(CustomVideoPlayerController controller) {
//     return BetterPlayer(controller: controller.betterPlayerController!);
//   }
// }
