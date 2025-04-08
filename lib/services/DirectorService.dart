import 'package:myott/services/api_endpoints.dart';
import 'package:myott/services/api_service.dart';

import '../UI/Director/Model/DirectorModel.dart';

class DirectorService {
  ApiService _apiService = ApiService();

  Future<DirectorDetailsModel?> fetchDirectorDetails(String directorSlug) async {
    try {
      final response = await _apiService.get("${APIEndpoints.directorDetails(directorSlug)}");

      if (response != null && response.statusCode == 200) {
        final data = response.data;

        if (data != null && data is Map<String, dynamic>) {
          return DirectorDetailsModel.fromJson(data);
        } else {
          throw Exception("Invalid response format: Expected JSON object but got null or incorrect data type.");
        }
      } else {
        throw Exception("Failed to fetch director details. Status Code: ${response?.statusCode ?? 'Unknown'}");
      }
    } catch (e) {
      print("Error in fetchDirectorDetails: $e");
      return null;
    }
  }
}
