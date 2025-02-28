import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Home/Controller/genre_controller.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import 'Controller/Audio_controller.dart';

class MoviesByGenre extends StatelessWidget {
  final GenreController genreController = Get.find<GenreController>();
  final MovieController movieController = Get.find<MovieController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          genreController.selectedGenre.value?.name ?? "Movies",
          style: TextStyle(color: Colors.white), // Explicitly setting white color
        )),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white), // Ensures back icon is white
      ),
      backgroundColor: Colors.black,
      body: Obx(() {
        final movies = genreController.moviesByGenre;

        if (movies.isEmpty) {
          return Center(
            child: Text(
              "No movies available in this language",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // movieController.setSelectedMovie(movies[index]); // Set selected movie
                },

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    movies[index].bannerUrl,  // Dynamically load movie posters
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
