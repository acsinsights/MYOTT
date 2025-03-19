import 'package:get/get.dart';
import 'package:myott/services/Setting_service.dart';
import 'package:myott/services/api_service.dart';
import '../Model/PageModel.dart';

class DynamicPageController extends GetxController {
  final SettingService _settingService = SettingService(ApiService()); // Proper DI
  var isLoading = false.obs;

  var termsAndConditions = <CustomPage>[].obs;
  var privacyAndPolicy = <CustomPage>[].obs;
  var aboutUs = <CustomPage>[].obs;
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
        termsAndConditions.value = response;
      } else {
        termsAndConditions.clear();
      }
    } catch (e) {
      print("Error fetching page content: $e");
      termsAndConditions.clear();
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchPrvacyAndPolicy() async {
    try {
      isLoading(true);
      var response = await _settingService.getPandP("Privacy_Policy");

      if (response.isNotEmpty) {
        privacyAndPolicy.value = response;
      } else {
        privacyAndPolicy.clear();
      }
    } catch (e) {
      print("Error fetching page content: $e");
      privacyAndPolicy.clear();
    } finally {
      isLoading(false);
    }
  }
  Future<void> fetchAboutUs() async {
    try {
      isLoading(true);
      var response = await _settingService.getPandP("About_Us");

      if (response.isNotEmpty) {
        aboutUs.value = response;
      } else {
        aboutUs.clear();
      }
    } catch (e) {
      print("Error fetching page content: $e");
      aboutUs.clear();
    } finally {
      isLoading(false);
    }
  }

}
