import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActorList extends StatelessWidget {
  const ActorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var actorsImages = [
      "assets/images/actors/actor1.png",
      "assets/images/actors/actor2.png",
      "assets/images/actors/actor3.png",
      "assets/images/actors/actor4.png",
      "assets/images/actors/actor5.png",
    ];

    var actorNames = [
      "Robert Downey Jr.",
      "Chris Hemsworth",
      "Scarlett Johansson",
      "Chris Evans",
      "Tom Holland",
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actorsImages.length,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(actorsImages[index]), // Removed `const`
                ),
               
              ],
            ),
          );
        },
      ),
    );
  }
}
