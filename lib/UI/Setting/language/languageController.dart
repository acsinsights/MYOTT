import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../services/translation_service.dart';

class LanguageController extends GetxController {
  var locale = 'en'.obs;
  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    String? savedLang = _storage.read('language');
    if (savedLang != null) {
      locale.value = savedLang;
      TranslationService.changeLocale(savedLang);
    }
  }

  void changeLanguage(String languageCode) {
    locale.value = languageCode;
    _storage.write('language', languageCode);
    TranslationService.changeLocale(languageCode);
  }
}
