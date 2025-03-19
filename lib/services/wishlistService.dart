import 'package:myott/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistService {
  final ApiService apiService = ApiService();

  Future<bool> updateWishlist({required int id, required String type, required int value}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("access_token");

      var response = await apiService.post(
        "addwishlist?secret=06c51069-0171-4f23-bf8f-41c9cd86762d",
        data: {
          "id": id,
          "type": type,
          "value": value,
        },
        token: token,
      );

      if (response != null && response.statusCode == 200) {
        await _updateLocalWishlist(id, value); // ✅ Local Storage Update
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("❌ Error updating wishlist: $e");
      return false;
    }
  }

  Future<bool> removeFromWishlist(int movieId) async {
    try {
      var response = await apiService.get("removemovie/$movieId");

      if (response != null && response.statusCode == 200) {
        await _updateLocalWishlist(movieId, 0); // ✅ Remove from local storage
        return true;
      } else {
        print("❌ Failed to remove from wishlist: ${response?.statusCode}");
        return false;
      }
    } catch (e) {
      print("❌ Error removing from wishlist: $e");
      return false;
    }
  }

  Future<void> saveWishlist(List<int> wishlistIds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('wishlist', wishlistIds.map((id) => id.toString()).toList());
  }

  Future<List<int>> loadWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedWishlist = prefs.getStringList('wishlist');

    if (savedWishlist != null) {
      return savedWishlist.map((id) => int.parse(id)).toList();
    }
    return [];
  }

  Future<void> _updateLocalWishlist(int movieId, int value) async {
    List<int> wishlist = await loadWishlist();
    if (value == 1) {
      wishlist.add(movieId);
    } else {
      wishlist.remove(movieId);
    }
    await saveWishlist(wishlist);
  }
}
