import 'package:myott/services/api_service.dart';

import '../UI/Genre/Model/GenreMandTModel.dart';
import 'api_endpoints.dart';

class GenreService{
  ApiService _apiService;
  GenreService(this._apiService);

  Future<GenreDetailsResponseModel?> fetchMoviesByGenre(String genreSlug) async {
    try {
      final response = await _apiService.get(APIEndpoints.moviesByGenre(genreSlug));
      if(response?.statusCode==200 || response?.data!=null){
        final data=response?.data;
        print("API Call URL: ${data}");

        return GenreDetailsResponseModel.fromJson(data);
      }else{
        throw Exception("Failed to fetch movies by genre");

      }
    } on Exception catch (e) {
      // TODO
      throw Exception("Error in fetchGenreMandT: $e");

    }

  }

}