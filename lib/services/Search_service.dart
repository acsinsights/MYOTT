import 'package:dio/dio.dart';
import 'package:myott/services/api_endpoints.dart';
import '../UI/Model/searchable_content.dart';
import '../UI/Search/Model/SearchModel.dart';
import '../services/api_service.dart'; // Ensure correct path to ApiService

class SearchService {
  final ApiService _apiService = ApiService();

  Future<List<SearchableContent>> fetchSearchResults(String query) async {
    try {
      Response? response = await _apiService.get(
        "search",  // Keep only the endpoint
        params: {
          "secret": "06c51069-0171-4f23-bf8f-41c9cd86762d",
          "searchTerm": query
        },
      );
      // ✅ Debug: Print the full API response
      print("API Response: ${response?.data}");

      final jsonData = response?.data;
      List<SearchableContent> searchResults = [];

      if (jsonData == null || jsonData['results'] == null) {
        print("❌ No results found in API response");
        return [];
      }

      if (jsonData['results']['movies']?['data'] != null) {
        searchResults.addAll(
          (jsonData['results']['movies']['data'] as List)
              .map((e) => MoviesDatum.fromJson(e))
              .toList(),
        );
      }

      if (jsonData['results']['tv_series']?['data'] != null) {
        searchResults.addAll(
          (jsonData['results']['tv_series']['data'] as List)
              .map((e) => TvSeriesDatum.fromJson(e))
              .toList(),
        );
      }

      if (jsonData['results']['audio']?['data'] != null) {
        searchResults.addAll(
          (jsonData['results']['audio']['data'] as List)
              .map((e) => AudioDatum.fromJson(e))
              .toList(),
        );
      }

      print("✅ Parsed ${searchResults.length} results.");
      return searchResults;
    } catch (e) {
      print("❌ Error fetching search results: $e");
      return [];
    }
  }

}
