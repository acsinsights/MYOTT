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
            tvseriesController.toggleWishlist(series!.series.id, "S");
          },
          child: Column(
            children: [
              Obx(() => Icon(
                tvseriesController.isWishlisted.value
                    ? CupertinoIcons.heart_fill
                    : CupertinoIcons.add,
                color: tvseriesController.isWishlisted.value
                    ? Colors.red
                    : Colors.white,
              )),

              SizedBox(height: 10),
              Obx(() =>
                  Text(
                    tvseriesController.isWishlisted.value
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
              RatingBottomSheet(movieId: series!.series.id, type: "T"),
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
      ],
    );
  }
}
