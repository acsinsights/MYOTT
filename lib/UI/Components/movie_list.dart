import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Model/Moviemodel.dart';
import 'package:myott/UI/Movie/movie_details_page.dart';
import 'package:myott/Utils/app_text_styles.dart';

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
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: ()=> Get.to(MovieDetailScreen()),
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
                        image: NetworkImage(movies[index].posterImg),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) => AssetImage('assets/images/placeholder.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      movies[index].name,
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
