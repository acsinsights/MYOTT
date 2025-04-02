import 'package:dio/dio.dart';
import 'package:myott/services/api_endpoints.dart';
import 'package:myott/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentService {
  ApiService apiService = ApiService();

  Future<dynamic> sendComment(Map<String, dynamic> comment) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final token = preferences.getString("access_token");

      if (token == null) {
        return {"error": "User not authenticated"};
      }

      Response? response = await apiService.post(
        APIEndpoints.addcomment,
        token: token,
        data: comment,
      );

      return response?.data; // Returning response data instead of raw response
    } catch (e) {
      print("Error in sendComment: $e");
      return {"error": "Failed to send comment"};
    }
  }

  Future<dynamic> replyComment(Map<String, dynamic> reply) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final token = preferences.getString("access_token");

      if (token == null) {
        return {"error": "User not authenticated"};
      }

      Response? response = await apiService.post(
        "endpoint", // Replace with actual API endpoint
        token: token,
        data: reply,
      );

      return response?.data;
    } catch (e) {
      print("Error in replyComment: $e");
      return {"error": "Failed to reply to comment"};
    }
  }
}
