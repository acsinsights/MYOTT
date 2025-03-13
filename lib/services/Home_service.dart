import 'package:dio/dio.dart';
import 'package:myott/UI/Home/Model/SliderItemModel.dart';
import 'package:myott/UI/Genre/Model/genre_model.dart';
import '../UI/Actors/Model/ActorsModel.dart';
import '../UI/Home/Model/HomePageModel.dart';
import '../UI/Model/Moviesmodel.dart';
import '../UI/Home/Model/Audio_Model.dart';
import 'api_endpoints.dart';
import 'api_service.dart';

class HomeService {
  final ApiService _apiService;

  HomeService(this._apiService); // Dependency Injection

  Future<HomePageModel?> fetchHomePageData() async {
    try {
      Response? response = await _apiService.get("${APIEndpoints.homeEndpoint}"); // API Endpoint

      if (response != null && response.statusCode == 200) {
        return HomePageModel.fromJson(response.data);
      } else {
        print("Failed to fetch HomePage Data");
        return null;
      }
    } catch (e) {
      print("Error in fetchHomePageData: $e");
      return null;
    }
  }

}
