import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/Actors/ActorsDetailedScreen.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
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
        if(homeController.actors.isEmpty){
          return ActorShimmerLoader();
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: homeController.actors.length,
          padding: const EdgeInsets.only(left: 16),
          itemBuilder: (context, index) {
            var actor= homeController.actors[index];
            return InkWell(
              // onTap: ()=> Get.to(ActorsDetailedScreen()),
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(actor.image), // Removed `const`
                    ),
                    Text(actor.name,style: AppTextStyles.SubHeading2,)

                  ],
                ),
              ),
            );
          },
        );
      }

      )
    );
  }
}
