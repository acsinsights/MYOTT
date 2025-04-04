import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Wishlist/Model/wishlistModel.dart';
import '../../services/wishlistService.dart';
import '../Movie/Movie_details_page.dart';
import 'WishListController.dart';

class ShowWishlistPage extends StatelessWidget {
  ShowWishlistPage({super.key});

  final WishlistController wishlistController = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    wishlistController.fetchWishlistData();
    return DefaultTabController(
      length: 2, // Movies & TV Series
      child: Scaffold(
        backgroundColor: Colors.black, // ✅ Background Black
        appBar: AppBar(
          title: Text("My Wishlist", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black, // ✅ AppBar Black
          bottom: TabBar(
            indicatorColor: Colors.red, // ✅ Red Indicator
            labelColor: Colors.white, // ✅ White Active Text
            unselectedLabelColor: Colors.grey, // ✅ Grey Inactive Text
            tabs: [
              Tab(icon: Icon(Icons.movie, color: Colors.white), text: "Movies"),
              Tab(icon: Icon(Icons.tv, color: Colors.white), text: "TV Series"),
            ],
          ),
        ),
        body: Obx(() {
          if (wishlistController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return TabBarView(
              children: [
                _buildSection("Movies", wishlistController.movies),
                _buildSection("TV Series", wishlistController.tvSeries),
              ],
            );
          }
        }),
      ),
    );
  }

  Widget _buildSection(String title, List<dynamic> items) {
    if (items.isEmpty) {
      return Center(
        child: Text("No $title in Wishlist",
            style: TextStyle(color: Colors.white, fontSize: 18)),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.5,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          if (item == null) return SizedBox(); // Prevents null errors

          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (item is Movie) {
                    Get.to(() => MovieDetailsPage(), arguments: {
                      "slug": item.slug
                    });
                  } else if (item is Series) {
                    // Get.to(() => TvSeriesDetailsPage(slug: item.slug));
                  }
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
                          item.thumbnailImg,
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
                        item.name,
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
              ),

              /// 🔴 **Remove Button** (Top Right Corner)
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () async {
                    if (item is Movie) {
                      await WishlistService().removeMovieFromWatchlist(id: item.id);
                      print(item.id);
                    } else if (item is Series) {
                      await wishlistController.removeSeriesFromWishlist(item.id);
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.6),
                    radius: 15.r,
                    child: Icon(
                      CupertinoIcons.trash,
                      color: Colors.red,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
