import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/notificationService.dart';
import '../Model/NotificationModel.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[].obs; // Observable List
  var isLoading = true.obs; // Loading state
  var unreadCount = 0.obs;
  final NotificationService notificationService;

  NotificationController(this.notificationService);

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading(true);
      var fetchedNotifications = await notificationService.getNotifications();
      notifications.assignAll(fetchedNotifications); // ✅ Update List
      print("Fetched Notifications: $notifications"); // Debugging
    } catch (e) {
      print("Error fetching notifications: $e");
    } finally {
      isLoading(false);
    }
  }

}
