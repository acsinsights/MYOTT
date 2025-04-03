import 'package:dio/dio.dart';
import 'package:myott/services/api_endpoints.dart';
import '../UI/Model/searchable_content.dart';
import '../UI/Search/Model/SearchModel.dart';
import '../services/api_service.dart';

class SearchService {
  final ApiService _apiService = ApiService();

  Future<SearchModel?> fetchSearchResults(String query) async {
    try {
      var response = await _apiService.get(APIEndpoints.searchMovies(query));

      if (response != null && response.data != null) {
        return SearchModel.fromJson(response.data);
      } else {
        throw Exception("No data received from API");
      }
    } catch (e, stackTrace) {
      print("Error in fetchSearchResults: $e");
      print(stackTrace);  // Logs the error trace for debugging
      return null;
    }
  }

}
