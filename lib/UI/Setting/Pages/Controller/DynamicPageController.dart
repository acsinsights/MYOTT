import 'package:get/get.dart';
import 'package:myott/services/Setting_service.dart';
import 'package:myott/services/api_service.dart';
import '../Model/PageModel.dart';

class DynamicPageController extends GetxController {
  final SettingService _settingService = SettingService(ApiService()); // Proper DI
  var isLoading = false.obs;

  var termsAndConditions = <CustomPage>[].obs; // Use CustomPage instead of PageModel
  var privacyAndPolicy = <CustomPage>[].obs; // Use CustomPage instead of PageModel
  var aboutUs = <CustomPage>[].obs; // Use CustomPage instead of PageModel
  @override
  void onInit() {
    super.onInit();
    fetchTermsAndCondition();
    fetchPrvacyAndPolicy();
    fetchAboutUs();
  }

  Future<void> fetchTermsAndCondition() async {
    try {
      isLoading(true);
      var response = await _settingService.getPandP("Terms_And_Condition");

      if (response.isNotEmpty) {
        termsAndConditions.value = response; // Store the list of CustomPage
      } else {
        termsAndConditions.clear(); // Clear if empty
      }
    } catch (e) {
      print("Error fetching page content: $e");
      termsAndConditions.clear(); // Handle error
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchPrvacyAndPolicy() async {
    try {
      isLoading(true);
      var response = await _settingService.getPandP("Terms_And_Condition");

      if (response.isNotEmpty) {
        privacyAndPolicy.value = response; // Store the list of CustomPage
      } else {
        privacyAndPolicy.clear(); // Clear if empty
      }
    } catch (e) {
      print("Error fetching page content: $e");
      privacyAndPolicy.clear(); // Handle error
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchAboutUs() async {
    try {
      isLoading(true);
      var response = await _settingService.getPandP("Terms_And_Condition");

      if (response.isNotEmpty) {
        aboutUs.value = response; // Store the list of CustomPage
      } else {
        aboutUs.clear(); // Clear if empty
      }
    } catch (e) {
      print("Error fetching page content: $e");
      aboutUs.clear(); // Handle error
    } finally {
      isLoading(false);
    }
  }

}
