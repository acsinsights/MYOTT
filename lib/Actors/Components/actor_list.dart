import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Actors/ActorsDetailedScreen.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/UI/Home/Controller/Home_controller.dart';
import '../../services/Home_service.dart';
import '../../services/api_service.dart';
import '../../UI/Components/MovieListShrimerLoad.dart';

class ActorList extends StatelessWidget {
  const ActorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController(HomeService(ApiService())));

    return SizedBox(
      height: 100,
      child: Obx(() {
        if (homeController.homePageData.value!.actors.isEmpty) {
          return ActorShimmerLoader();
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: homeController.homePageData.value!.actors.length,
          padding: const EdgeInsets.only(left: 16),
          itemBuilder: (context, index) {
            var actor = homeController.homePageData.value!.actors[index];
            return GestureDetector(
              onTap: () {
                final actorsdata=homeController.homePageData.value!.actors[index];
                Get.to(() => ActorsDetailedScreen(
                 actors: actorsdata,
                ));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade300, // Placeholder color
                      child: ClipOval(
                        child: Image.network(
                          actor.image,
                          width: 80, // Diameter of CircleAvatar
                          height: 80,
                          fit: BoxFit.contain, // Ensures the image fills the circle properly
                          errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                        ),
                      ),
                    ),




                    Text(actor.name, style: AppTextStyles.SubHeading2),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
