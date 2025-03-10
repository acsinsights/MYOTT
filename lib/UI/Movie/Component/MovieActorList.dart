// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:myott/UI/Home/Controller/Home_controller.dart';
// import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
// import 'package:myott/services/MovieService.dart';
//
// import '../../../services/Home_service.dart';
// import '../../../services/api_service.dart';
// import '../../Components/MovieListShrimerLoad.dart';
//
// class ActorList extends StatelessWidget {
//   const ActorList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final MovieController homeController = Get.put(MovieController(MoviesService(ApiService())));
//
//     return SizedBox(
//         height: 100,
//         child: Obx(() {
//           if(homeController.actors.isEmpty){
//             return ActorShimmerLoader();
//           }
//           return ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: homeController.actors.length,
//             padding: const EdgeInsets.only(left: 16),
//             itemBuilder: (context, index) {
//               var actor= homeController.actors[index];
//               return Padding(
//                 padding: const EdgeInsets.only(right: 12.0),
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 35,
//                       backgroundImage: NetworkImage(actor.image), // Removed `const`
//                     ),
//
//                   ],
//                 ),
//               );
//             },
//           );
//         }
//
//         )
//     );
//   }
// }
