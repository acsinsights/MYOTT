import 'package:dio/dio.dart';
import 'package:myott/UI/Setting/Models/SettingModel.dart';
import 'package:myott/services/api_endpoints.dart';
import 'package:myott/UI/Setting/Models/LanguageModel.dart';
import 'package:myott/UI/Profile/screens/SubscriptionPackage/Model/PackageModel.dart';
import 'package:myott/UI/Setting/Pages/Model/PageModel.dart';

import '../UI/Setting/Blogs/Model/blog_detail_model.dart';
import '../UI/Setting/Blogs/Model/blog_model.dart';
import '../UI/Setting/Faq/Model/FAQModel.dart';
import 'api_service.dart';

class SettingService {
  final ApiService _apiService;

  SettingService(this._apiService); // ✅ Dependency Injection


  Future<SettingModel?> fetchSettingData() async {
    try {
      Response? response = await _apiService.get("${APIEndpoints.settings}"); // API Endpoint

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
          return PlayerSettings.fromJson(data); // Convert map to PlayerSettings object
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

  Future<List<LanguageModel>> getLanguages({int page=1,int perPage=10})async{
    try {
      final response = await _apiService.get(APIEndpoints.settings, params: {
        "page": page,
        "per_page": perPage,
      });
      if (response?.statusCode == 200) {
        return (response?.data["languages"] as List<dynamic>? ?? [])
            .map((e) => LanguageModel.fromJson(e))
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

        return (data["Pages"] as List<dynamic>? ?? []) // Ensure correct key
            .map((e) => CustomPage.fromJson(e)) // Convert JSON to CustomPage
            .toList();
      } else {
        throw Exception("Failed to load pages");
      }
    } catch (e) {
      print("Error fetching pages: $e");
      return [];
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

  Future<BlogdetailsModel> fetchBlogDetails(int blogId) async {
    try {
      final response = await _apiService.get(APIEndpoints.blogDeatils(blogId));

      if (response?.statusCode == 200) {
        final data=response?.data;
        return BlogdetailsModel.fromJson(data);
      } else {
        throw Exception("Failed to fetch blog details");
      }
    } catch (e) {
      throw Exception("Error fetching blog details: $e");
    }
  }


  Future<List<PackageModel>> fetchPackages({int page = 1, int perPage = 10}) async {
    try {
      final response = await _apiService.get(APIEndpoints.Packages, params: {
        "page": page,
        "per_page": perPage,
      });

      if (response?.statusCode == 200) {
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


}