import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Utils/app_text_styles.dart';
import '../Movie/Controller/Movie_controller.dart';
import '../Movie/Model/movie_model.dart';

class MovieList extends StatelessWidget {
  final List<MovieModel> movies;
  final MovieController movieController = Get.find();

  MovieList({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => movieController.setSelectedMovie(movies[index]), // Navigate to details
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(movies[index].imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      movies[index].title,
                      style: AppTextStyles.SubHeading2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
