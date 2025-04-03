import 'package:get/get.dart';

import '../../services/Search_service.dart';
import 'Model/SearchModel.dart';


class CustomSearchController extends GetxController {
  final SearchService _searchService = SearchService();

  var searchResults = SearchModel(results: SearchResults(movies: [], tvSeries: [], audio: [], videos: [])).obs;
  var isLoading = false.obs;
  var searchQuery = "".obs;

  Future<void> fetchSearchResults(String query) async {
    if (query.isEmpty) return;

    try {
      isLoading.value = true;
      var response = await _searchService.fetchSearchResults(query);

      print("Raw API Response: ${response}");
      print("Parsed Movies: ${searchResults.value.results.movies}");
      print("Parsed TV Series: ${searchResults.value.results.tvSeries}");
      print("Parsed Audio: ${searchResults.value.results.audio}");
      print("Parsed Videos: ${searchResults.value.results.videos}");


      if (response != null) {
        searchResults.value = response;
      } else {
        searchResults.value = SearchModel(
          results: SearchResults(movies: [], tvSeries: [], audio: [], videos: []),
        );
      }
    } catch (e) {
      print("Error fetching search results: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
