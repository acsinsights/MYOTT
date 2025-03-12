import 'package:flutter/material.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Home/Model/ActorsModel.dart';

class ActorsDetailedScreen extends StatelessWidget {
  final ActorsModel actors;
  const ActorsDetailedScreen({Key? key,  required this.actors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button & Profile Image
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(actors.image), // Use NetworkImage for dynamic data
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),

            // Artist Name
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                actors.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(color: Colors.grey, thickness: 1),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                child: Text(actors.description,style: AppTextStyles.SubHeading2,),
              ),
            )

            // Section Title
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: Text(
            //     "Movies of $artistName",
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
