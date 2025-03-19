import 'package:dio/dio.dart';

import '../UI/Home/Model/HomePageModel.dart';

import 'api_endpoints.dart';
import 'api_service.dart';

class HomeService {
  final ApiService _apiService;

  HomeService(this._apiService);

  Future<HomePageModel?> fetchHomePageData() async {
    try {
      Response? response = await _apiService.get("${APIEndpoints.homeEndpoint}");

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
