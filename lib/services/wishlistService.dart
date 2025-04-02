import 'dart:convert';
import 'package:myott/UI/Wishlist/Model/wishlistModel.dart';
import 'package:myott/services/api_endpoints.dart';
import 'package:myott/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistService {
  final ApiService apiService = ApiService();

  Future<List<WishlistModel>> fetchWatchList() async {
    final response = await apiService.get(APIEndpoints.showWishlist);

    print("Response from API: ${response?.data}"); // ✅ Debugging Line

    if (response != null && response.statusCode == 200) {
      if (response.data is Map && response.data.containsKey("wishlist")) {
        var wishlistData = response.data["wishlist"];

        return wishlistData.map<WishlistModel>((json) => WishlistModel.fromJson(json)).toList();
      } else {
        throw Exception("Invalid response format: Expected a map with 'wishlist' key");
      }
    } else {
      throw Exception("Failed to load wishlist: ${response?.statusCode}");
    }
  }

  Future<bool> addToWishlist({required String type, required int id, required int value}) async {

    try {
      SharedPreferences prefs=await SharedPreferences.getInstance();
      final token= prefs.getString("access_token");
      final response = await apiService.post(
        token: token,
        APIEndpoints.addwishlist,
        data: {
          "type": type,
          "id": id,
          "value": value
        },
      );

      print("🛒 Wishlist API Response: ${response?.data}");

      if (response != null && response.statusCode == 200) {
        print("✅ Wishlist updated successfully!");
        return true;
      } else {
        print("⚠️ Failed to update wishlist. Status: ${response?.statusCode}");
        return false;
      }
    } catch (e) {
      print("❌ Error adding to wishlist: $e");
      return false;
    }
  }

  Future<bool> removeMovieFromWatchlist({required int id}) async {
    try {
      final response = await apiService.get("${APIEndpoints.removeMovie}/$id");

      if (response != null && response.statusCode == 200) {
        print("✅ Successfully removed movie from wishlist: $id");
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

  Future<bool> removeSeriesFromWatchlist({required int id}) async {
    try {
      final response = await apiService.get("${APIEndpoints.removeSeries}/$id");

      if (response != null && response.statusCode == 200) {
        print("✅ Successfully removed movie from wishlist: $id");
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

}
