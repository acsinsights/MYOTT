import 'dart:convert';

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
        await _updateLocalWishlist(id,type ,value);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("❌ Error updating wishlist: $e");
      return false;
    }
  }

  Future<bool> removeFromWishlist(int movieId, String type) async {
    try {
      var response = await apiService.get("removemovie/$movieId");

      if (response != null && response.statusCode == 200) {
        await _updateLocalWishlist(movieId,type,0);
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

  Future<List<Map<String, dynamic>>> fetchWishlistFromServer() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("access_token");

      var response = await apiService.get("showwishlist");

      print("🔵 Raw Wishlist Response: ${response?.data}"); // Debugging

      if (response != null && response.statusCode == 200) {
        var data = response.data;

        // 🛠 Extract List from Map
        if (data is Map<String, dynamic> && data.containsKey("wishlist")) {
          List<dynamic> wishlist = data["wishlist"]; // ✅ Extracting list

          return wishlist.map((item) => Map<String, dynamic>.from(item)).toList();
        } else {
          print("❌ Unexpected Wishlist Format: $data");
          return [];
        }
      } else {
        print("❌ Wishlist API failed: ${response?.statusCode}");
        return [];
      }
    } catch (e) {
      print("❌ Error fetching wishlist: $e");
      return [];
    }
  }



  Future<void> saveWishlist(List<Map<String, dynamic>> wishlist) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String wishlistJson = jsonEncode(wishlist);
    prefs.setString('wishlist', wishlistJson);
  }

  Future<List<Map<String, dynamic>>> loadWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? wishlistJson = prefs.getString('wishlist');

    if (wishlistJson != null) {
      List<dynamic> decodedList = jsonDecode(wishlistJson);
      return decodedList.map((item) => Map<String, dynamic>.from(item)).toList();
    }
    return [];
  }


  Future<void> _updateLocalWishlist(int movieId, String type, int value) async {
    List<Map<String, dynamic>> wishlist = await loadWishlist();

    if (value == 1) {
      wishlist.add({"id": movieId, "type": type});
    } else {
      wishlist.removeWhere((item) => item["id"] == movieId && item["type"] == type);
    }

    await saveWishlist(wishlist);
  }

  Future<List<Map<String, dynamic>>> fetchMovieDetails(List<int> movieIds) async {
    if (movieIds.isEmpty) return [];

    try {
      // ✅ Parallel API Calls
      List<Future<Map<String, dynamic>?>> requests = movieIds.map((id) async {
        var response = await apiService.get("movie/$id?secret=06c51069-0171-4f23-bf8f-41c9cd86762d");
        if (response != null && response.statusCode == 200) {
          return Map<String, dynamic>.from(response.data);
        }
        return null;
      }).toList();

      List<Map<String, dynamic>> movieDetails = (await Future.wait(requests)).whereType<Map<String, dynamic>>().toList();
      return movieDetails;
    } catch (e) {
      print("❌ Error fetching movie details: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchTvSeriesDetails(List<int> tvSeriesIds) async {
    if (tvSeriesIds.isEmpty) return [];

    try {
      List<Future<Map<String, dynamic>?>> requests = tvSeriesIds.map((id) async {
        var response = await apiService.get("tvseries/$id?secret=06c51069-0171-4f23-bf8f-41c9cd86762d");
        if (response != null && response.statusCode == 200) {
          return Map<String, dynamic>.from(response.data);
        }
        return null;
      }).toList();

      List<Map<String, dynamic>> tvSeriesDetails = (await Future.wait(requests)).whereType<Map<String, dynamic>>().toList();
      return tvSeriesDetails;
    } catch (e) {
      print("❌ Error fetching TV series details: $e");
      return [];
    }
  }


}
