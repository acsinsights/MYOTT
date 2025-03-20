import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import 'package:myott/UI/Search/search_Controller.dart';
import 'package:myott/UI/TvSeries/TvSeries_details_page.dart';
import '../Model/searchable_content.dart';
import '../Movie/Movie_details_page.dart';

class SearchScreen extends StatelessWidget {
  final CustomSearchController searchController = Get.put(CustomSearchController());
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text("Search", style: AppTextStyles.Headingb4),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController,
              onChanged: searchController.fetchResults,
              decoration: InputDecoration(
                labelText: "Search...",
                labelStyle: TextStyle(color: Colors.white54),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                prefixIcon: Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: Colors.white12,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (searchController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              final results = searchController.searchResults;

              if (results.isEmpty) {
                return Center(child: Text("No results found", style: AppTextStyles.SubHeading2));
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return buildSearchResultItem(results[index]);
                },
              );

            }),
          ),
        ],
      ),
    );
  }


  Widget buildSearchResultItem(SearchableContent content) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          content.posterImg,
          fit: BoxFit.cover,
          width: 60,
          height: 90,
          errorBuilder: (context, error, stackTrace) =>
              Image.asset("assets/images/movies/SliderMovies/movie-3.png", width: 60, height: 90),
        ),
      ),
      title: Text(content.name, style: TextStyle(color: Colors.white)),
      onTap: () {
        switch (content.type) {
          case ContentType.movie:
            // Get.to(() => MovieDetailsPage(movieId: content.id));
            break;
          case ContentType.tvSeries:
            Get.to(() => TvSeriesDetailsPage(seriesId: content.id));
            break;
          case ContentType.audio:
            // Get.to(()=> AudioDetailsPage(audioId: content.id));

            break;
        }
      },
    );
  }

}
