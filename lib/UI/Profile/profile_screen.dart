import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/Services/MovieService.dart';
import 'package:myott/Services/api_service.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/UI/Profile/Components/SubscriptionBanner.dart';
import 'package:myott/UI/Profile/Components/UserProfile.dart';
import 'package:myott/UI/Profile/screens/create_profile.dart';
import 'package:myott/UI/Profile/screens/edit_profile.dart';
import 'package:myott/UI/Profile/screens/SubscriptionPackage/subscription_page.dart';
import 'package:myott/UI/Setting/setting_page.dart';

import 'Components/MovieListComponent.dart';



class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final MovieController movieController = Get.put(MovieController(MoviesService(ApiService())));
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        // elevation: 0,
        title: Text("Profile".tr, style: GoogleFonts.poppins(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Get.to(HelpAndSettingScreen());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subscription Banner
            SubscriptionBanner(),
            // User Profile
UserProfile(),
            SizedBox(height: 16),

            Text("ContinueWatching".tr, style: GoogleFonts.poppins(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
           // MovieListComponent(movies: movieController.movies, isContinueWatching: true),
          ],
        ),
      ),
    );
  }
  final List<String> movieimages = [
    "assets/images/movie-1.png",
    "assets/images/movie-2.png",
    "assets/images/movie-3.png",
    "assets/images/movie-4.png",
    "assets/images/movie-1.png",
  ];
  Widget _buildMovieList(bool isContinueWatching) {
    return SizedBox(
      height: isContinueWatching ? 140 : 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieimages.length, // Use the length of movie images list
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Container(
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(movieimages[index]), // Load image from assets
                  fit: BoxFit.cover, // Make image cover the container
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  // Play Icon and Episode Info for Continue Watching
                  if (isContinueWatching)
                    Positioned(
                      bottom: 10,
                      left: 8,
                      child: Row(
                        children: [
                          const Icon(Icons.play_arrow, size: 16, color: Colors.white),
                          Text(
                            "E1 E2",
                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                  // Progress Bar for Continue Watching
                  if (isContinueWatching)
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 5,
                        width: 80,
                        color: Colors.redAccent,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}