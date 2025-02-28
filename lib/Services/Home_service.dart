import 'package:dio/dio.dart';
import 'package:myott/UI/Home/Model/genre_model.dart';
import '../UI/Home/Model/ActorsModel.dart';
import '../UI/Model/Moviemodel.dart';
import '../UI/Home/Model/Audio_Model.dart';
import 'api_endpoints.dart';
import 'api_service.dart';

class HomeService {
  final ApiService _apiService;

  HomeService(this._apiService); // Dependency Injection

  /// ✅ **Fetches Home Page Data (Movies, Actors, Languages) in One API Call**
  Future<Map<String, dynamic>> fetchHomeData() async {
    try {
      final response = await _apiService.get("${APIEndpoints.homeEndpoint}");

      if (response.statusCode == 200) {
        final data = response.data;

        return {
          "latest": (data["latest"] as List<dynamic>? ?? [])
              .map((e) => MoviesModel.fromJson(e))
              .toList(),
          "top_movies": (data["top_movies"] as List<dynamic>? ?? [])
              .map((e) => MoviesModel.fromJson(e))
              .toList(),
          "upcoming_movie": (data["upcoming_movie"] as List<dynamic>? ?? [])
              .map((e) => MoviesModel.fromJson(e))
              .toList(),
          "actors": (data["actors"] as List<dynamic>? ?? [])
              .map((e) => ActorsModel.fromJson(e))
              .toList(),
          "Audio": (data["Audio"] as List<dynamic>? ?? [])
              .map((e) => LangModel.fromJson(e))
              .toList(),
          "all_genres": (data["all_genres"] as List<dynamic>? ?? [])
          .map((e)=> GenreModel.fromJson(e))
          .toList(),
        };
      } else {
        throw Exception("Failed to fetch home data. Status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("API Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }
}
