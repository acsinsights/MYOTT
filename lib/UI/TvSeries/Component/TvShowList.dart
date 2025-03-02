import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Model/Moviesmodel.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import 'package:myott/UI/TvSeries/Model/TvSeriesModel.dart';
import 'package:myott/UI/TvSeries/tv_series_controller.dart';
import 'package:myott/Utils/app_text_styles.dart';

import '../../../Services/api_service.dart';
import '../../../Services/tv_series_service.dart';

class TvSeriesMovieList extends StatelessWidget {
  final List<TvSeriesModel> tvSeries;

  TvSeriesMovieList({Key? key, required this.tvSeries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TVSeriesController tvSeriesController =Get.put(TVSeriesController(TVSeriesService(ApiService())));

    if (tvSeries.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "No tvSeries available",
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
                Get.to(() => TvSeriesDetailsPage(seriesId: tvSeries[index].id));
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
                      image: DecorationImage(
                        image: NetworkImage(tvSeries[index].thumbnailImg),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) => AssetImage('assets/images/placeholder.png'),
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
