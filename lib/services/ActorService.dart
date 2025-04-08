import '../UI/Actors/Model/ActorDetailsModel.dart';
import 'package:myott/services/api_endpoints.dart';
import 'package:myott/services/api_service.dart';

class ActorSerivce{
  ApiService _apiService=ApiService();

  Future<ActorDetailsModel?> fetchActorsDetails(String actorSlug) async {
    try {
      final response = await _apiService.get("${APIEndpoints.actorDetails(actorSlug)}");

      if (response != null && response.statusCode == 200) {
        final data = response.data;

        if (data != null && data is Map<String, dynamic>) {
          return ActorDetailsModel.fromJson(data);
        } else {
          throw Exception("Invalid response format: Expected JSON object but got null or incorrect data type.");
        }
      } else {
        throw Exception("Failed to fetch actor details. Status Code: ${response?.statusCode ?? 'Unknown'}");
      }
    } catch (e) {
      print("Error in fetchActorsDetails: $e");
      return null;
    }
  }


}