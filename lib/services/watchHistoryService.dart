import 'package:myott/services/api_endpoints.dart';
import '../UI/WatchHistory/Model/WatchHistoryResponseModel.dart';
import 'api_service.dart';

class WatchHistoryService {
  ApiService apiService = ApiService();

  Future<WatchHistoryResponseModel?> showWatchHistory() async {
    try {
      final response = await apiService.get(APIEndpoints.showWatchHistoy);
      print(response?.data);

      return WatchHistoryResponseModel.fromJson(response?.data);
    } catch (e) {
      print("Error fetching watch history: $e");
      return null;
    }
  }

  Future<bool> addWatchHistory(String type, int contentId) async {
    try {
      final url = APIEndpoints.addWatchHistory(type, contentId);
      print("Donneeeeeeeeeeeeeeeeeeeee");
      await apiService.get(url);
      return true;
    } catch (e) {
      print("Error adding watch history: $e");
      return false;
    }
  }

  Future<bool> deleteWatchHistory(String type, int contentId) async {
    try {
      final url = APIEndpoints.deleteWatchHistory(type, contentId);
      await apiService.get(url);
      return true;
    } catch (e) {
      print("Error deleting watch history: $e");
      return false;
    }
  }
}
