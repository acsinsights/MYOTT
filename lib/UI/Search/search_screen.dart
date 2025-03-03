import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/UI/Search/search_Controller.dart';
import 'package:myott/Core/Utils/app_text_styles.dart';
import '../../../Core/Utils/app_colors.dart';
import '../Auth/Component/custom_text_field.dart';
import '../Components/Movie_grid.dart';
import '../Movie/Controller/Movie_controller.dart';

class SearchScreen extends StatelessWidget {
  final CustomSearchController searchController = Get.put(CustomSearchController());
  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                prefixIcon: Icons.search,
                suffixIcon: Icons.mic,
                controller: searchTextController,
                hintText: "Search movies, shows and more",
                onChanged: (query) {
                  searchController.searchMovies(query);
                },
              ),
              const SizedBox(height: 16),
              Text("Search History", style: AppTextStyles.SubHeadingb),
              const SizedBox(height: 12),
              Obx(() => searchController.searchHistory.isEmpty
                  ? Text("No recent searches", style: GoogleFonts.poppins(color: Colors.white))
                  : SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: searchController.searchHistory.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final movie = searchController.searchHistory[index];
                    return GestureDetector(
                      onTap: () {
                        searchTextController.text = movie.title;
                        searchController.searchMovies(movie.title);
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: 150,
                            padding: const EdgeInsets.only(right: 30),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: AssetImage(movie.bannerUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    movie.title,
                                    style: GoogleFonts.poppins(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => searchController.removeFromSearchHistory(movie),
                              child: const Icon(Icons.close, color: Colors.red, size: 20),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )),
              const SizedBox(height: 24),
              Text("Search Results", style: AppTextStyles.SubHeadingb),
              const SizedBox(height: 12),
              Obx(() => searchController.filteredMovies.isEmpty
                  ? Text("No movies found", style: GoogleFonts.poppins(color: Colors.white))
                  : MovieGrid(movies: searchController.filteredMovies)),
              const SizedBox(height: 24),
              Text("Popular Movies", style: AppTextStyles.SubHeadingb),
              const SizedBox(height: 12),
              Obx(() => MovieGrid(movies: searchController.popularMovies.value)),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
