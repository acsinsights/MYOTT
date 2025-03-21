import 'package:myott/services/api_service.dart';

import '../UI/Genre/Model/GenreMandTModel.dart';
import 'api_endpoints.dart';

class GenreService{
  ApiService _apiService;
  GenreService(this._apiService);

  Future<GenreMandTModel> fetchMoviesByGenre(int genreId) async {
    try {
      final response = await _apiService.get(APIEndpoints.moviesByGenre(genreId));
      if(response?.statusCode==200 || response?.data!=null){
        final data=response?.data;
        return GenreMandTModel.fromJson(data);
      }else{
        throw Exception("Failed to fetch movies by genre");

      }
    } on Exception catch (e) {
      // TODO
      throw Exception("Error in fetchGenreMandT: $e");

    }

  }

}