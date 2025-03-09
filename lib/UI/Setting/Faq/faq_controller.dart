import 'package:get/get.dart';
import '../../../services/Setting_service.dart';
import 'Model/FAQModel.dart';

class FAQController extends GetxController {
  var faqList = <FaqModel>[].obs;
  var isLoading = true.obs;
  var expandedIndexes = <int, RxBool>{}.obs; // Tracks which FAQ items are expanded

  final SettingService _settingService;

    FAQController(this._settingService);

  @override
  void onInit() {
    super.onInit();
    fetchFAQList();
  }

  Future<void> fetchFAQList() async {
    try {
      isLoading(true);
      final data = await _settingService.getFAQList();
      faqList.assignAll(data);

      // Initialize expansion tracking for each item
      for (int i = 0; i < faqList.length; i++) {
        expandedIndexes[i] = false.obs;
      }
    } catch (e) {
      print("Error fetching FAQs: $e");
    } finally {
      isLoading(false);
    }
  }

  void toggleExpansion(int index) {
    if (expandedIndexes.containsKey(index)) {
      expandedIndexes[index]!.value = !expandedIndexes[index]!.value;
    }
  }
}
