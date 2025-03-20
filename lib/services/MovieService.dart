import 'package:myott/UI/Movie/Model/movie_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UI/Model/Moviesmodel.dart';
import 'package:myott/services/api_service.dart';
import 'api_endpoints.dart';
import 'package:dio/dio.dart';

class MoviesService {
  final ApiService _apiService;

  MoviesService(this._apiService);

    Future<MovieDetailsModel> getMovieDetails(String slug) async {
    try {
      final response = await _apiService.get(APIEndpoints.movieDetails(slug));

      if (response?.statusCode == 200) {
        final data=response?.data;
        return MovieDetailsModel.fromJson(data);
      } else {
        throw Exception("Failed to fetch movie details. Status: ${response?.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("API Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }

  Future<List<MoviesModel>> searchMovies(String query) async {
    try {
      final response = await _apiService.get("${APIEndpoints.searchMovies}?query=$query");

      if (response?.statusCode == 200) {
        return (response?.data["results"] as List<dynamic>? ?? [])
            .map((e) => MoviesModel.fromJson(e))
            .toList();
      } else {
        throw Exception("No results found. Status: ${response?.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("API Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }

  Future<bool> rateMovie({
    required int movieId,
    required String type, 
    required String review,
    required int rating,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final String? token = preferences.getString("access_token");

      Map<String, dynamic> data = {
        "id": movieId,
        "type": type,
        "review": review,
        "rating": rating,
      };

      Response? response = await _apiService.post("rating", data: data, token: token);

      if (response != null && response.statusCode == 200) {
        print("✅ Rating submitted: ${response.data}");
        return true;
      } else {
        print("❌ Failed to submit rating: ${response?.statusCode}");
        return false;
      }
    } catch (e) {
      print("❌ Error submitting rating: $e");
      return false;
    }
  }

}
