import 'package:dio/dio.dart';
import 'package:myott/services/api_endpoints.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/UI/TvSeries/Model/TVSeriesDetailsModel.dart';
import 'package:myott/UI/TvSeries/Model/TvSeriesModel.dart';

class TVSeriesService {
  final ApiService apiService=ApiService();


  Future<List<TvSeriesModel>> fetchTVSeries() async {
    try {
      final response = await apiService.get(APIEndpoints.tvSeries);

      if (response?.statusCode == 200) {
        final List<dynamic> data = response?.data;
        return data.map((e) => TvSeriesModel.fromJson(e)).toList();
      } else {
        print("Error: ${response?.statusCode} - ${response?.statusMessage}");
      }
    } on DioException catch (e) {
      print("API Error: ${e.response?.statusCode} - ${e.message}");
    } catch (e) {
      print("Unexpected Error from TvSeries: $e");
    }
    return [];
  }

  Future<SeriesDetailResponse?> fetchTVSeriesDetails(String slug) async {
    try {
      final response = await apiService.get(APIEndpoints.tvSeriesDetails(slug));

      if (response?.statusCode == 200) {
        final data = response?.data;
        return SeriesDetailResponse.fromJson(data);
      } else {
        print("Error: ${response?.statusCode} - ${response?.statusMessage}");
      }
    } on DioException catch (e) {
      print("API Error: ${e.response?.statusCode} - ${e.message}");
    } catch (e) {
      print("Unexpected Error in fetchtvseriesdetails: $e");
    }
    return null;
  }
}
