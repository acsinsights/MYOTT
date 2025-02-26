import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(BaseOptions(
    baseUrl: "https://templatecookies.com/ott/public/api/",
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      Response response = await _dio.get(endpoint, queryParameters: params);
      return response;
    } catch (e) {
      throw Exception("API Error: $e");
    }
  }
}
