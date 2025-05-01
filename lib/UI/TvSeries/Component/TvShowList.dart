import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Home/Model/HomeSeries.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import 'package:myott/UI/TvSeries/Model/TvSeriesModel.dart';
import 'package:myott/UI/TvSeries/Controller/tv_series_controller.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import '../../../services/api_service.dart';
import '../../../services/tv_series_service.dart';

class TvSeriesMovieList extends StatelessWidget {
  final List<HomeSeries> tvSeries;

  TvSeriesMovieList({Key? key, required this.tvSeries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tvSeries.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "No TV Series available",
            style: AppTextStyles.SubHeading2.copyWith(color: Colors.white),
          ),
        ),
      );
    }

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tvSeries.length,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              final slug = tvSeries[index].slug;
              Get.to(() => TvSeriesDetailsPage(),
                  arguments: {
                "slug":slug
                  },
                  binding: BindingsBuilder(() {
                    Get.put(TVSeriesController());
                  }));
            },
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
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        tvSeries[index].thumbnailImg,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/movies/SliderMovies/movie-1.png',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      tvSeries[index].name,
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
