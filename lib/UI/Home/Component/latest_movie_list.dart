import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Home/Model/latestMandTModel.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/UI/Model/Moviesmodel.dart';
import 'package:myott/UI/Movie/movie_details_page.dart';

import '../../../Core/Utils/app_common.dart';
import '../../../Core/Utils/app_text_styles.dart';
import '../../../services/MovieService.dart';
import '../../Components/ShimmerLoader.dart';
import '../../Components/network_image_widget.dart';
import '../../Movie/Controller/Movie_controller.dart';
import '../../TvSeries/TvSeries_details_page.dart'; // Import Series Controller

class LatestMandSList extends StatelessWidget {
  final List<Movie> movies;
  final List<Series> series;

  LatestMandSList({Key? key, required this.movies, required this.series}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MediaItem> latestList = [
      ...movies.map((movie) => MediaItem(
        id: movie.id,
        name: movie.name,
        imageUrl: movie.posterImg,
        slug: movie.slug,
        type: MediaType.movie,
        isfree: movie.package.free,
      )),
      ...series.map((series) => MediaItem(
        id: series.id,
        name: series.name,
        imageUrl: series.thumbnailImg,
        slug: series.slug,
        type: MediaType.series,
        isfree: series.seriesPackage!.free,
      )),
    ];

    if (latestList.isEmpty) {
      return SizedBox();
    }

    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: latestList.length,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          final item = latestList[index];

          return GestureDetector(
            onTap: () {
              if (item.type == MediaType.movie) {
                Get.to(() => MovieDetailsPage(),arguments: {
                  "movieId": item.id,
                  "slug": item.slug
                },
                    binding: BindingsBuilder(() {
                      Get.put(MovieController());
                    }));
              } else if (item.type == MediaType.series) {
                Get.to(() => TvSeriesDetailsPage(),arguments: {
                  "slug":item.slug
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      // Movie/Series Poster
                      Container(
                        width: 120,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: NetworkImageWidget(imageUrl: item.imageUrl,
                          errorAsset: "assets/images/movies/SliderMovies/movie-1.png",
                        ),
                      ),
                      // Free/Paid Badge
                      // Positioned(
                      //   top: 8,
                      //   right: 8,
                      //   child: Container(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 8, vertical: 4),
                      //     decoration: BoxDecoration(
                      //       color: item.isfree ? Colors.green : Colors.red,
                      //       borderRadius: BorderRadius.circular(6),
                      //     ),
                      //     child: Text(
                      //       item.isfree ? "FREE" : "PAID",
                      //       style: const TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 120,
                    child: Text(
                      item.name,
                      style: AppTextStyles.SubHeading2,
                      textAlign: TextAlign.center,
                      maxLines: 2,
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
