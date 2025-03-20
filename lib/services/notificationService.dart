import 'package:myott/services/api_service.dart';
import 'dart:convert';
import '../UI/Notification/Model/NotificationModel.dart';

class NotificationService {
  ApiService apiService = ApiService();

  Future<List<NotificationModel>> getNotifications() async {
    var response = await apiService.get("notifications"); // ✅ Ensure await is used

    print("Response Status Code: ${response?.statusCode}");
    print("Response Body: ${response?.data}");

    if (response?.statusCode == 200) {
      var decodedData = response?.data;
      print("Decoded Data: $decodedData");

      var data = decodedData['notifications']; // ✅ Get notifications list

      if (data is List) { // ✅ Ensure it's a list
        print("Notifications List: $data");
        return data.map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        print("Error: notifications is not a list");
        throw Exception("Invalid response format: notifications is not a list");
      }
    } else {
      print("Error fetching notifications");
      throw Exception("Failed to load notifications");
    }
  }

  Future<bool> readNotification(String notificationId) async {
    var response = await apiService.post("readnotification", // ✅ Use correct API
        data: {"id": notificationId}); // ✅ No need to encode manually

    return response?.statusCode == 200;
  }
}
