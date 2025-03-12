import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(BaseOptions(
    baseUrl: "https://templatecookies.com/ott/public/api/",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<Response?> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      return await _dio.get(endpoint, queryParameters: params);
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<Response?> post(String endpoint, {Map<String, dynamic>? data, String? token}) async {
    try {
      return await _dio.post(

        endpoint,
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token", // Add Bearer Token
            "Content-Type": "application/json", // Ensure JSON data
          },
        ),
      );
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<Response?> putRequest(String endpoint, Map<String, dynamic> data) async {
    try {
      Response response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      print('PUT Request Error: $e');
      return null;
    }
  }

  Future<Response?> deleteRequest(String endpoint) async {
    try {
      Response response = await _dio.delete(endpoint);
      return response;
    } catch (e) {
      print('DELETE Request Error: $e');
      return null;
    }
  }


  void _handleError(DioException e) {
    print("API Error: ${e.response?.data ?? e.message}");
  }
}
