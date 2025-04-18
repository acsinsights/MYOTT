import 'package:dio/dio.dart';
import 'package:myott/UI/Setting/HelpAndSupport/Model/AddSupportModel.dart';
import 'package:myott/UI/Setting/HelpAndSupport/Model/SupportTypeModel.dart';
import 'package:myott/UI/Setting/Models/SettingModel.dart';
import 'package:myott/UI/Setting/PaymentHistory/Model/payment_history_model.dart';
import 'package:myott/services/api_endpoints.dart';
import 'package:myott/UI/Profile/screens/SubscriptionPackage/Model/PackageModel.dart';
import 'package:myott/UI/Setting/Pages/Model/PageModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UI/Setting/Blogs/Model/blog_detail_model.dart';
import '../UI/Setting/Blogs/Model/blog_model.dart';
import '../UI/Setting/Faq/Model/FAQModel.dart';
import 'api_service.dart';

class SettingService {
  final ApiService _apiService=ApiService();



  Future<SettingModel?> fetchSettingData() async {
    try {
      Response? response = await _apiService.get("${APIEndpoints.settings}");

      if (response != null && response.statusCode == 200) {
        return SettingModel.fromJson(response.data);
      } else {
        print("Failed to fetch Setting Data");
        return null;
      }
    } catch (e) {
      print("Error in fetchHomePageData: $e");
      return null;
    }
  }

  Future<PlayerSettings?> getPlayerSetting() async {
    try {
      final response = await _apiService.get(APIEndpoints.settings);

      if (response?.statusCode == 200) {
        final data = response?.data["player_settings"] as Map<String, dynamic>?;

        if (data != null) {
          return PlayerSettings.fromJson(data);
        } else {
          throw Exception("Player settings data is null");
        }
      } else {
        throw Exception("Failed to load settings");
      }
    } catch (e) {
      print("Error fetching Settings: $e");
      return null;
    }
  }

  Future<List<Language>> getLanguages({int page=1,int perPage=10})async{
    try {
      final response = await _apiService.get(APIEndpoints.settings, params: {
        "page": page,
        "per_page": perPage,
      });
      if (response?.statusCode == 200) {
        return (response?.data["languages"] as List<dynamic>? ?? [])
            .map((e) => Language.fromJson(e))
            .toList();
      }else{
        throw Exception("Failed to load languages");
      }


    }catch(e){
      print("Error fetching languages: $e");
      return [];
    }
  }
//FAQ
  Future<List<FaqModel>> getFAQList({int page = 1, int perPage = 10}) async {
    try {
      final response = await _apiService.get(APIEndpoints.faq, params: {
        "page": page,
        "per_page": perPage,
      });

      if (response?.statusCode == 200) {
        final data = response?.data;

        return (data["data"] as List<dynamic>? ?? [])
            .map((e) => FaqModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to load FAQs");
      }
    } catch (e) {
      print("Error fetching FAQs: $e");
      return [];
    }
  }

  Future<List<CustomPage>> getPandP(String PageName) async {
    try {
      final response = await _apiService.get(APIEndpoints.pages(PageName));

      if (response?.statusCode == 200) {
        final data = response?.data;

        return (data["Pages"] as List<dynamic>? ?? [])
            .map((e) => CustomPage.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to load pages");
      }
    } catch (e) {
      print("Error fetching pages: $e");
      return [];
    }
  }

  Future<String> UserDeleteReq() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final String? token = preferences.getString("access_token");

      Response? response = await _apiService.post("account/delete", token: token);

      if (response != null && response.statusCode == 200) {
        if (response.data != null && response.data['success'] == true) {
          print("✅ Request successful: ${response.data}");
          return response.data['message'] ?? "Account deleted successfully";
        } else {
          print("❌ API returned success status but no success message.");
          return "Failed to delete account";  // Treat it as failure
        }
      } else {
        print("❌ Request failed with status: ${response?.statusCode}");
        return "Failed to delete account";
      }
    } catch (e) {
      print("❌ Error sending request: $e");
      return "Something went wrong!";
    }
  }


  //Blogs
  Future<List<BlogModel>> fetchBlogs({int page = 1, int perPage = 10}) async {
    try {
      final response = await _apiService.get(APIEndpoints.blogs, params: {
        "page": page,
        "per_page": perPage,
      });

      if (response?.statusCode == 200) {
        return (response?.data["data"] as List<dynamic>? ?? [])
            .map((e) => BlogModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to fetch blogs");
      }
    } catch (e) {
      throw Exception("Error fetching blogs: $e");
    }
  }

  Future<BlogdetailsModel> fetchBlogDetails(String slug) async {
    try {
      final response = await _apiService.get(APIEndpoints.blogDetails(slug));

      if (response == null) {
        throw Exception("No response received from server.");
      }

      if (response.statusCode == 200) {
        return BlogdetailsModel.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch blog details. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching blog details: ${e.toString()}");
    }
  }


  Future<List<PackageModel>> fetchPackages({int page = 1, int perPage = 10}) async {
    try {
      final response = await _apiService.get(APIEndpoints.packages, params: {
        "page": page,
        "per_page": perPage,
      });

      if (response?.statusCode == 200 ) {
        return (response?.data["Packages"] as List<dynamic>? ?? [])
            .map((e) => PackageModel.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to fetch packages");
      }
    } catch (e) {
      print("Error fetching packages: $e");
      throw Exception("Something went wrong while fetching packages");
    }
  }


  //Help and Support
  Future<SupportTypeModel> getHelpAndSupport() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final token = preferences.getString("access_token");

      var response = await _apiService.get(APIEndpoints.supportType);

      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        return SupportTypeModel.fromJson(response.data);
      } else {
        throw Exception("Something went wrong: ${response?.statusCode}");
      }
    } catch (e) {
      print("Error in getHelpAndSupport: $e");
      throw Exception("Failed to load support types");
    }
  }

  Future<AddSupportModel> addSupport(int supportId, String message) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final token = preferences.getString("access_token");

      var response = await _apiService.post(
        APIEndpoints.addSupport,
        token: token,
        data: {
          "support_id": supportId,
          "message": message,
        },
      );

      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        return AddSupportModel.fromJson(response.data);
      } else {
        throw Exception("API Error: ${response?.statusCode} - ${response?.data}");
      }
    } catch (e) {
      print("Error in addSupport: $e");
      throw Exception("Failed to send support request");
    }
  }

  //Payment and Subscription
  Future<PaymentHistoryModel> getPaymentHistory() async {
    try{
      var response=await _apiService.get(APIEndpoints.paymentHistory);
      if(response!=null && (response.statusCode==200 || response.statusCode==201)){
        return PaymentHistoryModel.fromJson(response.data);
      }else{
        throw Exception("Something went wrong: ${response?.statusCode}");
      }
    }catch(e){
      print("Error in getHelpAndSupport: $e");
      throw Exception("Failed to load support types");
    }
}



}