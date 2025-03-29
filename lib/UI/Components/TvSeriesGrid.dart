import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/TvSeries/Model/TvSeriesModel.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';

class TvSeriesGrid extends StatelessWidget {
  final List<TvSeriesModel> tvSeries;
  final String? title;

  const TvSeriesGrid({Key? key, required this.tvSeries, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(title ?? '', style: AppTextStyles.Headingb4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.5,
          ),
          itemCount: tvSeries.length,
          itemBuilder: (context, index) {
            final tvseries = tvSeries[index];

            return GestureDetector(
              onTap: () {
                Get.to(() => TvSeriesDetailsPage(slug: tvseries.slug));
              },
              child: Column(
                children: [
                  Container(
                    height: 150.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.network(
                        tvseries.thumbnailImg,
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
      ),
    );
  }
}
