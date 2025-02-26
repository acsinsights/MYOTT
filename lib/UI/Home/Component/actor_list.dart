import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/UI/Home/Controller/Home_controller.dart';

import '../../../Services/Home_service.dart';
import '../../../Services/api_service.dart';

class ActorList extends StatelessWidget {
  const ActorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController(HomeService(ApiService())));

    return SizedBox(
      height: 100,
      child: Obx(() {
        if(homeController.actors.isEmpty){
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: homeController.actors.length,
          padding: const EdgeInsets.only(left: 16),
          itemBuilder: (context, index) {
            var actor= homeController.actors[index];
            return Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(actor.image), // Removed `const`
                  ),

                ],
              ),
            );
          },
        );
      }

      )
    );
  }
}
