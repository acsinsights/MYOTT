import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Setting/Models/SettingModel.dart';
import '../../../services/Setting_service.dart';
import '../../Core/Utils/app_common.dart';
import '../Components/custom_button.dart';
import 'HelpAndSupport/Model/AddSupportModel.dart';
import 'HelpAndSupport/Model/SupportTypeModel.dart';
import 'Models/LanguageModel.dart';

class SettingController extends GetxController {
  var langList=<Language>[].obs;
  var playerSetting=<PlayerSettings>[].obs;
  var isLoading = false.obs;
  var selectedLanguage = "en".obs; // Store selected language
  var settingData= Rxn<SettingModel>();

  var supportTypeList = <SupportTypeData>[].obs;
  var addSupport=<AddSupportModel>[].obs;
  var isSubmitting = false.obs;
  var successMessage = ''.obs;
  var errorMessage = ''.obs;
  var selectedSupportType = Rxn<SupportTypeData>(); // Holds the selected support type

  void setSelectedSupportType(SupportTypeData supportType) {
    selectedSupportType.value = supportType;
  }
  final SettingService _settingService=SettingService();

  @override
  void onInit() {
    super.onInit();
    getLang();
    getPlayerSettings();

  }


  Future<void> deleteAccount() async {
    try {
      isLoading.value = true;
      update();

      String message = await _settingService.UserDeleteReq();

      if (message == "Failed to delete account" || message == "Something went wrong!") {
        throw Exception("Account deletion failed");
      }

      Get.snackbar("Success", message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP);

    } catch (e) {
      Get.snackbar("Error", "Something went wrong!",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> fetchSettingData() async {
    try {
      isLoading(true);

      final SettingModel? data = await _settingService.fetchSettingData();

      if (data != null) {
        settingData.value = data;

      } else {
        print("No data received from API");
      }
    } catch (e) {
      print("Error fetching Setting data: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getPlayerSettings() async {
    isLoading(true);
    try {
      final PlayerSettings? data = await _settingService.getPlayerSetting();

      if (data != null) {
        playerSetting.assignAll([data]); // Wrap it inside a list
      } else {
        print("No player settings received");
      }

    } catch (e) {
      print("Error fetching settings: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getLang()async{
    isLoading(true);
    try {
      final data = await _settingService.getLanguages();
      langList.assignAll(data);
      print(data);
    } catch (e) {
      print("Error fetching languages: $e");
    }
    isLoading(false);
  }

  Future<void> fetchSupportTypes() async {
    try {
      isLoading.value = true;
      final response = await _settingService.getHelpAndSupport();
      if (response != null ) {
        supportTypeList.assignAll(response.data);
      } else {
        showSnackbar("Error", response.message,isError: true);
      }
    } catch (e) {
      showSnackbar("Error", "Failed to fetch support types",isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitSupportRequest(String message) async {
    if (selectedSupportType.value == null) {
      Get.snackbar("Error", "No support type selected", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      isSubmitting.value = true;
      errorMessage.value = '';
      successMessage.value = '';

      final response = await _settingService.addSupport(selectedSupportType.value!.id, message);

      if (response.success) {
        successMessage.value = response.message;
        showSnackbar("Success", response.message);
      } else {
        errorMessage.value = "Failed to submit support request";
        showSnackbar("Error", errorMessage.value,isError: true);

      }
    } catch (e) {
      errorMessage.value = "Something went wrong!";
      showSnackbar("Error", errorMessage.value,isError: true);
    } finally {
      isSubmitting.value = false;
    }
  }


  void selectLanguage(String languageCode) {
    selectedLanguage.value = languageCode;
  }

}
