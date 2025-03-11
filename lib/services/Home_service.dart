import 'package:dio/dio.dart';
import 'package:myott/UI/Home/Model/SliderModel.dart';
import 'package:myott/UI/Genre/Model/genre_model.dart';
import '../UI/Home/Model/ActorsModel.dart';
import '../UI/Model/Moviesmodel.dart';
import '../UI/Home/Model/Audio_Model.dart';
import 'api_endpoints.dart';
import 'api_service.dart';

class HomeService {
  final ApiService _apiService;

  HomeService(this._apiService); // Dependency Injection

  /// ✅ **Fetches Home Page Data (Movies, Actors, Languages) in One API Call**
  Future<Map<String, dynamic>> fetchHomeData() async {
    try {
      print("Fetching home data...");

      final response = await _apiService.get("${APIEndpoints.homeEndpoint}");

      if (response == null || response.data == null) {
        throw Exception("API response is null");
      }

      final data = response.data as Map<String, dynamic>;

      // 🔥 Print the entire API response
      print("✅ Full API Response: $data");

      return {
        "latest": data["latest"] != null ? (data["latest"] as List).map((e) => MoviesModel.fromJson(e)).toList() : [],
        "top_movies": data["top_movies"] != null ? (data["top_movies"] as List).map((e) => MoviesModel.fromJson(e)).toList() : [],
        "new_arrivals": data["new_arrivals"] != null ? (data["new_arrivals"] as List).map((e) => MoviesModel.fromJson(e)).toList() : [],
        "upcoming_movie": data["upcoming_movie"] != null ? (data["upcoming_movie"] as List).map((e) => MoviesModel.fromJson(e)).toList() : [],
        "actors": data["actors"] != null ? (data["actors"] as List).map((e) => ActorsModel.fromJson(e)).toList() : [],
        "slider": data["slider"] != null ? (data["slider"] as List).map((e) => SliderModel.fromJson(e)).toList() : [],
        "Audio": data["Audio"] != null ? (data["Audio"] as List).map((e) => AudioModel.fromJson(e)).toList() : [],
        "all_genres": data["all_genres"] != null ? (data["all_genres"] as List).map((e) => GenreModel.fromJson(e)).toList() : [],
      };
    } catch (e) {
      print("❌ Error: $e");
      throw Exception("Unexpected Error: $e");
    }
  }
}
