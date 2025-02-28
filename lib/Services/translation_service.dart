import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TranslationService extends Translations {
  static final langs = ['en', 'ar', 'hi', 'zh'];

  static final locales = [
    Locale('en'),
    Locale('ar'),
    Locale('hi'),
    Locale('zh'),
  ];

  static Map<String, Map<String, String>> translations = {};

  /// 🚀 **Load translations from JSON files**
  static Future<void> loadTranslations() async {
    for (var lang in langs) {
      try {
        String jsonString = await rootBundle.loadString('assets/lang/$lang.json');
        Map<String, dynamic> jsonMap = json.decode(jsonString);
        translations[lang] = jsonMap.map((key, value) => MapEntry(key, value.toString()));
      } catch (e) {
        print("❌ Error loading $lang.json: $e");
      }
    }
    print("✅ Translations Loaded: ${translations.keys}");
  }

  /// ✅ **GetX uses this for translations**
  @override
  Map<String, Map<String, String>> get keys => translations;

  static Locale getLocale(String lang) {
    int index = langs.indexOf(lang);
    return (index != -1) ? locales[index] : Locale('en');
  }

  static void changeLocale(String lang) {
    final locale = getLocale(lang);
    Get.updateLocale(locale);
    print("🔄 Locale changed to: $lang");
  }
}
