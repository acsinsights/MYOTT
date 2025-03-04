import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Components/MovieListShrimerLoad.dart';
import 'package:myott/UI/Genre/Controller/genre_controller.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/UI/Movie/Movie_details_page.dart';

import '../../Services/MovieService.dart';
import '../../Services/api_service.dart';

class MoviesByGenre extends StatelessWidget {
  final GenreController genreController = Get.find<GenreController>();
  // final MovieController movieController = Get.find<MovieController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          genreController.selectedGenre.value?.name ?? "Movies",
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Obx(() {
        if (genreController.isLoading.value) {
          return Column(
            children: [
              MovieShrimmerLoader()
            ],
          );
        }

        final movies = genreController.moviesByGenre;
        if (movies.isEmpty) {
          return Center(
            child: Text(
              "No movies available in this genre",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.5,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return GestureDetector(
                  onTap: () {
                    // movieController.setSelectedMovie(movie); // Set selected movie
                    // Get.to(() => MovieDetailsPage(), arguments: movie);
                    Get.to(() => MovieDetailsPage(movieId: movie.id),
                        binding: BindingsBuilder(() {
                          Get.put(MovieController(MoviesService(ApiService()))); // Ensure Controller is available
                        }));
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: movie.posterImg.isNotEmpty
                            ? Image.network(
                          movie.posterImg, // Load image dynamically
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Image(image: AssetImage("assets/images/movies/SliderMovies/movie-1.png")),
                        )
                            : Image(image: AssetImage("assets/images/movies/SliderMovies/movie-1.png"))
                      ),
                      Text(movie.name,style: AppTextStyles.SubHeading2,overflow: TextOverflow.ellipsis,)

                    ],
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
