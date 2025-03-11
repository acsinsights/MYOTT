import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/TvSeries/Model/TvSeriesModel.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/UI/Movie/Controller/Movie_controller.dart';
import 'package:myott/UI/Movie/movie_details_page.dart';

class TvSeriesGird extends StatelessWidget {
  final List<TvSeriesModel> tvSeries;
  final String? title;

  const TvSeriesGird({Key? key, required this.tvSeries, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(title!, style: AppTextStyles.Headingb4,
        ),),
      body: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h), // Responsive Padding
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ScreenUtil().screenWidth > 600 ? 4 : 3, // Adjusts for tablets
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.6.h,
        ),
        itemCount: tvSeries.length,
        itemBuilder: (context, index) {
          final tvseries = tvSeries[index];

          return GestureDetector(
            onTap: () {
              final tvseriesId = tvseries.id;
              Get.to(() => TvSeriesDetailsPage(seriesId: tvseriesId));
            },
            child: Column(
              children: [
                Container(
                  height: 140.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    image: DecorationImage(
                      image: NetworkImage(tvseries.thumbnailImg), // Use NetworkImage if from API
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    tvseries.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
