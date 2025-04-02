import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Audio/Controller/AudioController.dart';
import 'package:myott/UI/Movie/Movie_details_page.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';

import '../../Core/Utils/app_text_styles.dart';
import 'Model/AudioDeatilsResponseModel.dart';

class MoviesByAudio extends StatelessWidget {
  final AudioController controller = Get.put(AudioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(controller.selectedAudio.value?.name ?? "Audio Details"),backgroundColor: Colors.black,foregroundColor: Colors.white,),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: EdgeInsets.all(10),
          children: [
            // Movies Section
            if (controller.movies.isNotEmpty) buildSection("Movies", controller.movies),

            // Series Section
            if (controller.series.isNotEmpty) buildSection("Series", controller.series),

            // Videos Section
            if (controller.videos.isNotEmpty) buildSection("Videos", controller.videos),

            // Audio Section
            if (controller.audios.isNotEmpty) buildSection("Audio", controller.audios),
          ],
        );
      }),
    );
  }

  // Generic method to build a section
  Widget buildSection(String title, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(title, style: AppTextStyles.SubHeadingb),
        ),
        SizedBox(
          height: 180.h, // Fixed height for image list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              return buildItemCard(item);
            },
          ),
        ),
      ],
    );
  }

  // Card Item UI
  Widget buildItemCard(dynamic item) {
    return GestureDetector(
      onTap: () {
        if (item is AuidoMovie) {
          Get.to(() => MovieDetailsPage(),arguments: {
            "slug":item.slug
          });
        } else if (item is AudioSeries) {
          Get.to(() => TvSeriesDetailsPage(slug: item.slug));
        } else if (item is AudioVideo) {
          // Get.to(() => VideoDetailsScreen(video: item));
        } else if (item is Audio) {
          // Get.to(() => AudioDetailsScreen(audio: item));
        }
      },
      child: Container(
        width: 100.w,
        height: 120.h, // Fixed width for items
        margin: EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(item.thumbnailImg ?? "https://via.placeholder.com/120"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5),
            // Title
            Text(
              item.name ?? "Unknown",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTextStyles.SubHeading2,
            ),
          ],
        ),
      ),
    );
  }
}
