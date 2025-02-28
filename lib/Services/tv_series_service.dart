import 'package:dio/dio.dart';
import 'package:myott/Services/api_endpoints.dart';
import 'package:myott/Services/api_service.dart';
import 'package:myott/UI/TvSeries/Model/TvSeriesModel.dart';

class TVSeriesService {
  final ApiService apiService;

  TVSeriesService(this.apiService);

  Future<List<TvSeriesModel>> fetchTVSeries() async {
    try {
      final response = await apiService.get(APIEndpoints.tvSeries); // Ensure correct API endpoint

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data; // Extract JSON data

        return data.map((e) => TvSeriesModel.fromJson(e)).toList(); // Map JSON to model
      } else {
        print("Error: ${response.statusCode} - ${response.statusMessage}");
      }
    } on DioException catch (e) {
      print("API Error: ${e.response?.statusCode} - ${e.message}");
    } catch (e) {
      print("Unexpected Error: $e");
    }
    return []; // Return an empty list in case of failure
  }
}
