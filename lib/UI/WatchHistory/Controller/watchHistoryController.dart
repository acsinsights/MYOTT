import 'package:get/get.dart';
import 'package:myott/UI/WatchHistory/Model/WatchHistoryResponseModel.dart';
import 'package:myott/services/watchHistoryService.dart';

class WatchHistoryController extends GetxController {
  WatchHistoryService watchHistoryService = WatchHistoryService();

  var isLoading = false.obs;
  var watchHistoryList = <WatchHistory>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchWatchHistory();
  }

  void fetchWatchHistory() async {
    try {
      isLoading(true);
      final response = await watchHistoryService.showWatchHistory();
      if (response != null) {
        watchHistoryList.assignAll(response.watchHistory);
      }
    } catch (e) {
      print("Error loading watch history: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void>addHistory(String type, int id) async {
    final added = await watchHistoryService.addWatchHistory(type, id);
    if (added) {
      fetchWatchHistory();
    }
  }

  Future<void> deleteHistory(String type, int id) async {
    final deleted = await watchHistoryService.deleteWatchHistory(type, id);
    if (deleted) {
      fetchWatchHistory();
    }
  }
}
