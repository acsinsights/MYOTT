import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:myott/UI/TvSeries/Controller/tv_series_controller.dart';

import '../../../Core/Utils/app_text_styles.dart';
import '../../Movie/Component/RatingBottomSheet.dart';
import '../Model/TVSeriesDetailsModel.dart';

  class seriessActionButtons extends StatelessWidget {
  const seriessActionButtons({
    super.key,
    required this.tvseriesController,
    required this.series,
  });

  final TVSeriesController tvseriesController;
  final SeriesDetailResponse? series;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: (){
            // tvseriesController.toggleWishlist(series!.series.id, "M");
          },
          child: Column(
            children: [
              Obx(() => Icon(
                tvseriesController.isWatchlisted.value
                    ? CupertinoIcons.heart_fill
                    : CupertinoIcons.add,
                color: tvseriesController.isWatchlisted.value
                    ? Colors.red
                    : Colors.white,
              )),

              SizedBox(height: 10),
              Obx(() =>
                  Text(
                    tvseriesController.isWatchlisted.value
                        ? "Wishlisted"
                        : "WishList",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
        GestureDetector(
          onTap: (){
            tvseriesController.toggleRate();
            Get.bottomSheet(
              RatingBottomSheet(movieId: series!.series.id, type: "M"),
              isScrollControlled: true,
            );
          },
          child: Column(
            children: [
              Obx(() =>
                  Icon(
                    tvseriesController.isRated.value
                        ? CupertinoIcons.star_fill
                        : CupertinoIcons.star,
                    color: Colors.white,
                  )),
              SizedBox(height: 10),
              Obx(() =>
                  Text(
                    tvseriesController.isRated.value
                        ? "Rated"
                        : "Rate",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
        GestureDetector(
          onTap: (){
            tvseriesController.shareContent(series!.series.name, "series", series!.series.trailerUrl);
          },
          child: Column(
            children: [
              Icon(
                Icons.share,
                color: Colors.white,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Share",
                style: AppTextStyles.SubHeadingb3,
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            tvseriesController.toggleDownload();
          },
          child: Column(
            children: [
              Obx(() {
                return Icon(
                  tvseriesController.isDownloaded.value
                      ? Icons.download_done : Icons.download,
                  color: Colors.white,
                );
              }),
              SizedBox(
                height: 10.h,
              ),
              Obx(() {
                return Text(
                  tvseriesController.isDownloaded.value
                      ? "Downloaded" : "Download",
                  style: AppTextStyles.SubHeadingb3,
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}
