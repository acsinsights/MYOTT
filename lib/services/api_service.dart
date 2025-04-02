import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(BaseOptions(
    baseUrl: "https://templatecookies.com/ott/public/api/",
    connectTimeout: const Duration(seconds: 100),
    receiveTimeout: const Duration(seconds: 100),
  ));



  Future<Response?> get(String endpoint, {Map<String, dynamic>? params}) async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    final token=preferences.getString("access_token");
    try {
      return await _dio.get(endpoint, queryParameters: params,
      options: Options(
       headers: {
         "Authorization" :"Bearer $token",
         "Content-Type": "application/json"
       }

      )
      );
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<Response?> post(String endpoint, {
    Map<String, dynamic>? data,
    String? token,
    Map<String, String>? headers, // 👈 Accept custom headers
  }) async {
    try {
      return await _dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
            "Accept": "application/json",
            ...?headers,
          },
        ),
      );
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<Response?> postWithImage(String endpoint, {dynamic data, String? token}) async {
    try {
      return await _dio.post(
        endpoint,
        data: data,  // Accepts FormData now
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
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
    print("API Error: ${e.response?.statusCode} - ${e.response?.data}");
    print("Dio Error Type: ${e.type}");
    print("Dio Error Message: ${e.message}");
  }

}
