import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Movie/Movie_details_page.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import 'WishListController.dart';

class ShowWishlistPage extends StatefulWidget {
  @override
  State<ShowWishlistPage> createState() => _ShowWishlistPageState();
}

class _ShowWishlistPageState extends State<ShowWishlistPage> {
  final WishlistController wishlistController = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {


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
            return Center(child: CircularProgressIndicator(color: Colors.red));
          }

          return TabBarView(
            children: [
              _buildSection("Movies", wishlistController.movies, "movie"),
              _buildSection("TV Series", wishlistController.tvSeries, "tvseries"),
            ],
          );
        }),
      ),
    );
  }

  @override
  void initState() {
    wishlistController.fetchWishlistData();
  }

  Widget _buildSection(String title, List<Map<String, dynamic>> items, String type) {
    if (items.isEmpty) {
      return Center(
        child: Text("No $title in Wishlist",
            style: TextStyle(color: Colors.white, fontSize: 18)),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items[index][type]; // Dynamic key based on type
        return Card(
          color: Colors.grey[900], // ✅ Dark Grey Card
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: GestureDetector(
            onTap: () {
          int Id = int.tryParse(item["id"].toString()) ?? 0; // Convert ID to int safely

          if (type == "movie") {
            // Get.to(() => MovieDetailsPage(movieId: Id));
          } else {
            Get.to(() => TvSeriesDetailsPage(seriesId: Id));
          }

            },
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(item["poster_img"] ?? "",
                    width: 60, height: 60, fit: BoxFit.cover),
              ),
              title: Text(
                item["name"] ?? "Unknown",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // ✅ White Text
              ),
              subtitle: Text("Release: ${item["release_year"] ?? "N/A"}",
                  style: TextStyle(color: Colors.grey)), // ✅ Grey Subtitle
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red), // ✅ Red Delete Icon
                onPressed: () => wishlistController.removeFromWishlist(item["id"], type),
              ),
            ),
          ),
        );
      },
    );
  }
}
