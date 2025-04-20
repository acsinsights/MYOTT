import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Components/network_image_widget.dart';
import 'package:myott/UI/Movie/Movie_details_page.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import 'package:myott/UI/Video/video_Detials_page.dart';
import 'Model/SearchModel.dart';
import 'search_controller.dart';

class SearchScreen extends StatelessWidget {
  final CustomSearchController controller = Get.put(CustomSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      appBar: AppBar(
        title: Text("Search", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                controller.searchQuery.value = value;
                controller.fetchSearchResults(value);
              },
              style: TextStyle(color: Colors.white), // Light text input
              decoration: InputDecoration(
                hintText: "Search movies, TV shows, audio, videos...",
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator(color: Colors.redAccent));
              }

              var results = controller.searchResults.value.results;

              // Combine all content into a single list
              List<Map<String, dynamic>> allItems = [];

              allItems.addAll(results.movies.map((e) => {"item": e, "type": "movie"}));
              allItems.addAll(results.tvSeries.map((e) => {"item": e, "type": "tv"}));
              allItems.addAll(results.audio.map((e) => {"item": e, "type": "audio"}));
              allItems.addAll(results.videos.map((e) => {"item": e, "type": "video"}));

              if (allItems.isEmpty) {
                return Center(
                  child: Text(
                    "No results found",
                    style: TextStyle(color: Colors.white70),
                  ),
                );
              }

              return ListView.builder(
                itemCount: allItems.length,
                itemBuilder: (context, index) {
                  var item = allItems[index]["item"] as SearchMTVA;
                  var type = allItems[index]["type"] as String;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      child: ListTile(
                        tileColor: Colors.grey[900],
                        leading: item.thumbnailImg != null && item.thumbnailImg!.isNotEmpty
                            ? ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: NetworkImageWidget(imageUrl: item.thumbnailImg,height: 100,width: 100,errorAsset: "assets/images/movies/SliderMovies/movie-1.png",))
                            : Icon(Icons.image, size: 50, color: Colors.white70),
                        title: Text(item.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                        subtitle: Text(
                          "Maturity: ${item.maturity},\nRelease: ${item.releaseYear.year}",
                          style: TextStyle(color: Colors.white60),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white54),
                        onTap: () => _navigateToDetails(item, type),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }


  void _navigateToDetails(SearchMTVA item, String type) {
    switch (type) {
      case "movie":
        Get.to(() => MovieDetailsPage(), arguments: {"slug": item.slug});
        break;
      case "tv":
        Get.to(() => TvSeriesDetailsPage(), arguments: {"slug": item.slug});
        break;
      case "audio":
      // Get.to(() => AudioDetailsPage(), arguments: {"slug": item.slug});
        break;
      case "video":
        Get.to(() => VideoDetialsPage(), arguments: {"slug": item.slug});
        break;
    }
  }
}
