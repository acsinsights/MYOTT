import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../UI/Home/Model/HomePageModel.dart';

import 'api_endpoints.dart';
import 'api_service.dart';

class HomeService {
  final ApiService _apiService=ApiService();


  Future<HomePageModel?> fetchHomePageData() async {
    try {
      Response? response = await _apiService.get(APIEndpoints.homeEndpoint);

      if (response?.statusCode == 200) {
        print("✅ Home Page Data Loaded Successfully!");
        return HomePageModel.fromJson(response?.data);
      } else {
        print("⚠️ Failed to fetch Home Page Data. Status Code: ${response?.statusCode}");
        throw Exception("Server Error: ${response?.statusCode}");
      }
    } on DioException catch (e) {
      print("🚨 Dio Error: ${e.message}");
      throw Exception(_handleDioError(e));
    } on SocketException {
      print("🚨 No Internet Connection!");
      throw Exception("No Internet Connection. Please check your network.");
    } on TimeoutException {
      print("⏳ Request Timed Out!");
      throw Exception("Request timed out. Try again later.");
    } catch (e) {
      print("❌ Unknown Error: $e");
      throw Exception("Something went wrong. Please try again.");
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timed out.";
      case DioExceptionType.sendTimeout:
        return "Request send timed out.";
      case DioExceptionType.receiveTimeout:
        return "Response receive timed out.";
      case DioExceptionType.badResponse:
        return "Server responded with error: ${e.response?.statusCode}";
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      case DioExceptionType.unknown:
        return "Unexpected error occurred.";
      default:
        return "Something went wrong.";
    }
  }
}
