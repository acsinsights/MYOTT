import 'package:get/get.dart';
import '../../../Services/Setting_service.dart';
import 'Faq/Model/FAQModel.dart';
import 'Models/LanguageModel.dart';

class SettingController extends GetxController {
  var langList=<LanguageModel>[].obs;
  var isLoading = false.obs;
  var selectedLanguage = "en".obs; // Store selected language



  final SettingService _settingService;
  SettingController(this._settingService);

  @override
  void onInit() {
    super.onInit();
    getLang();
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
  void selectLanguage(String languageCode) {
    selectedLanguage.value = languageCode;
  }

}
