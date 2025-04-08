import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';

import 'package:myott/UI/Home/Controller/Home_controller.dart';

import '../../../services/Home_service.dart';
import '../../../services/api_service.dart';
import '../../Components/MovieListShrimerLoad.dart';
import '../../Components/section_title.dart';
import '../ActorsDetailedScreen.dart';


class ActorList extends StatelessWidget {
  const ActorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return SizedBox(
      height: 180,
      child: Obx(() {

        if (homeController.isLoading.value || homeController.homePageData.value!.actors.isEmpty) {
          return ActorShimmerLoader();
        }
        if (homeController.homePageData.value!.actors.isEmpty) {
          return SizedBox();
        }
        return Column(
          children: [
            SectionTitle(title: "Actors".tr, showAll: false),

            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: homeController.homePageData.value!.actors.length,
                padding: const EdgeInsets.only(left: 16),
                itemBuilder: (context, index) {
                  var actor = homeController.homePageData.value!.actors[index];
                  return GestureDetector(
                    onTap: () {
                      final actordata=homeController.homePageData.value!.actors[index];
                      Get.to(() => ActorsDetailedScreen(),arguments: {
                        "slug":actordata.slug

                      });
                      print(actor.image);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Container(
                        width: 80.w,
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.network(
                                actor.image,
                                width: 70,
                                height: 70,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.error, color: Colors.red);
                                },
                              ),
                            ),
              
                            Text(actor.name, style: AppTextStyles.SubHeading2,overflow: TextOverflow.ellipsis,
                            maxLines: 2,textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
