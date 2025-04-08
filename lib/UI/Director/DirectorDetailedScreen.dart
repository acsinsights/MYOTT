import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Components/MovieListShrimerLoad.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/UI/Video/video_Detials_page.dart';
import '../Movie/Movie_details_page.dart';
import 'Controller/DirectorController.dart';

class DirectorDetailedScreen extends StatefulWidget {
  const DirectorDetailedScreen({Key? key}) : super(key: key);

  @override
  State<DirectorDetailedScreen> createState() => _DirectorDetailedScreenState();
}

class _DirectorDetailedScreenState extends State<DirectorDetailedScreen> {
  final DirectorController directorController = Get.put(DirectorController());

  @override
  void initState() {
    final slug = Get.arguments['slug'];
    directorController.fetchDirectorDetails(slug);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Obx(() {
          final director = directorController.directorData.value;

          return director == null
              ? const Center(child: CircularProgressIndicator())
              : NestedScrollView(
            controller: directorController.scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  foregroundColor: Colors.white,
                  expandedHeight: 400.0,
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.black,
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: directorController.showTitle.value
                      ? Text(director.name ?? '', style: AppTextStyles.SubHeadingb2)
                      : const SizedBox.shrink(),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (director.image != null)
                          NetworkImageWidget(imageUrl: director.image,errorAsset: "assets/Avtars/avtar.jpg",),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.transparent
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 16,
                          right: 16,
                          child: Text(director.name ?? '', style: AppTextStyles.SubHeadingb2),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    if (director.bio != null)
                      HtmlWidget(director.bio!, textStyle: AppTextStyles.SubHeading2),
                    SizedBox(height: 20.h),

                    /// Movies
                    buildMediaSection(
                      title: "Movies by ${director.name}",
                      items: directorController.directorData.value?.movies ?? [],
                      isLoading: directorController.isLoading.value,
                      onTap: (movie) => Get.to(() => const MovieDetailsPage(), arguments: {
                        "slug": movie.slug,
                      }),
                    ),
                    SizedBox(height: 20.h),

                    /// Videos
                    buildMediaSection(
                      title: "Videos by ${director.name}",
                      items: directorController.directorData.value?.videos ?? [],
                      isLoading: directorController.isLoading.value,
                      onTap: (video) => Get.to(() => VideoDetialsPage(), arguments: {
                        "slug": video.slug,
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildMediaSection({
    required String title,
    required List<dynamic> items,
    required bool isLoading,
    required Function(dynamic item) onTap,
  }) {
    if (isLoading) return MovieShrimmerLoader();
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.SubHeadingb2),
          const Divider(color: Colors.grey, thickness: 1),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 8.h,
              childAspectRatio: 0.5,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () => onTap(item),
                child: Column(
                  children: [
                    Container(
                      height: 150.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        image: DecorationImage(
                          image: NetworkImage(item.thumbnailImg ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(
                        item.name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
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
