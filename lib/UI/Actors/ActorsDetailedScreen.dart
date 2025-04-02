import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Actors/Controller/ActorController.dart';
import 'package:myott/UI/Actors/Model/ActorsModel.dart';
import 'package:myott/UI/Components/MovieListShrimerLoad.dart';
import 'package:myott/UI/Components/Movie_grid.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import 'package:myott/UI/Video/video_Detials_page.dart';
import 'package:myott/services/ActorService.dart';
import 'package:myott/services/api_service.dart';

import '../../services/MovieService.dart';
import '../Movie/Controller/Movie_controller.dart';
import '../Movie/Movie_details_page.dart';

class ActorsDetailedScreen extends StatefulWidget {
  final ActorsModel actors;
  const ActorsDetailedScreen({Key? key, required this.actors}) : super(key: key);

  @override
  State<ActorsDetailedScreen> createState() => _ActorsDetailedScreenState();
}

class _ActorsDetailedScreenState extends State<ActorsDetailedScreen> {
  late final ActorController actorController;

  @override
  void initState() {
    super.initState();
    actorController = Get.put(ActorController(ActorSerivce(ApiService()), widget.actors.slug));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: NestedScrollView(
          controller: actorController.scrollController,
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
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Obx(() => actorController.showTitle.value
                    ? Text(widget.actors.name, style: AppTextStyles.SubHeadingb2)
                    : SizedBox.shrink()),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(widget.actors.image, fit: BoxFit.fill),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 16,
                        right: 16,
                        child: Text(widget.actors.name, style: AppTextStyles.SubHeadingb2),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(widget.actors.description, style: AppTextStyles.SubHeading2),
                  SizedBox(height: 10),
            
                  // Movies Section
                  Obx(() => buildMediaSection(
                    title: "Movies of ${widget.actors.name}",
                    items: actorController.actorData.value?.movies ?? [],
                    isLoading: actorController.isLoading.value,
                    onTap: (movie) => Get.to(() => MovieDetailsPage()),
                  )),
            
                  SizedBox(height: 10),
            
                  // Videos Section
                  Obx(() => buildMediaSection(
                    title: "Videos of ${widget.actors.name}",
                    items: actorController.actorData.value?.videos ?? [],
                    isLoading: actorController.isLoading.value,
                    onTap: (video) => Get.to(() => VideoDetialsPage()),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// **Reusable Widget for Movies/Videos Section**
  Widget buildMediaSection({
    required String title,
    required List<dynamic> items,
    required bool isLoading,
    required Function(dynamic item) onTap,
  }) {
    if (isLoading) return MovieShrimmerLoader();
    if (items.isEmpty) return SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.SubHeadingb2),
          Divider(color: Colors.grey, thickness: 1),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
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
                          image: NetworkImage(item.thumbnailImg),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(
                        item.name,
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
