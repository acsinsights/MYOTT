import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Services/api_service.dart';
import 'package:myott/UI/Model/Moviesmodel.dart';
import 'package:myott/UI/Movie/movie_details_page.dart';

import '../../Core/Utils/app_text_styles.dart';
import '../../Services/MovieService.dart';
import '../Movie/Controller/Movie_controller.dart';
import 'ShimmerLoader.dart';

class MovieList extends StatelessWidget {
  final List<MoviesModel> movies;

  MovieList({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "No movies available",
            style: AppTextStyles.SubHeading2.copyWith(color: Colors.white),
          ),
        ),
      );
    }

    return SizedBox(
      height: 240, // Increased height to accommodate text
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                final movieId = movies[index].id;
                Get.to(() => MovieDetailsPage(movieId: movieId),
                    binding: BindingsBuilder(() {
                      Get.put(MovieController(MoviesService(ApiService()))); // Ensure Controller is available
                    }));
              },
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(movies[index].posterImg),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) =>
                            ShimmerLoader(height: 180, width: 120,),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6), // Increased spacing to avoid overflow

                  // Ensure text fits properly within the container
                  SizedBox(
                    width: 120, // Match image width
                    child: Text(
                      movies[index].name,
                      style: AppTextStyles.SubHeading2,
                      textAlign: TextAlign.center, // Center the text
                      maxLines: 2, // Allow wrapping into the second line
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
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
