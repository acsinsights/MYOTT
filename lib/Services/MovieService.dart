import '../UI/Model/Moviesmodel.dart';
import 'api_service.dart';
import 'api_endpoints.dart';
import 'package:dio/dio.dart';

class MoviesService {
  final ApiService _apiService;

  MoviesService(this._apiService); // ✅ Dependency Injection

  /// 🔹 **Fetch Movie Details**
  Future<MoviesModel> getMovieDetails(int movieId) async {
    try {
      final response = await _apiService.get("${APIEndpoints.movieDetails}/$movieId");

      if (response.statusCode == 200) {
        return MoviesModel.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch movie details. Status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("API Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }

  /// 🔹 **Search Movies by Query**
  Future<List<MoviesModel>> searchMovies(String query) async {
    try {
      final response = await _apiService.get("${APIEndpoints.searchMovies}?query=$query");

      if (response.statusCode == 200) {
        return (response.data["results"] as List<dynamic>? ?? [])
            .map((e) => MoviesModel.fromJson(e))
            .toList();
      } else {
        throw Exception("No results found. Status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("API Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }
}
