import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/UI/Movie/movie_details_page.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import '../Movie/Model/movie_model.dart';

class MovieGrid extends StatelessWidget {
  final List<MovieModel> movies;

  const MovieGrid({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieController movieController=Get.put(MovieController());
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2 / 3,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigate using GetX and pass the movie data
            // movieController.setSelectedMovie(movies[index]);
            // Get.to(() => TvSeriesDetailsPage(seriesId: seriesId));
            Get.to(MovieDetailsPage());
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(movies[index].imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
