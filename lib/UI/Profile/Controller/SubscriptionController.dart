import 'package:get/get.dart';
import 'package:myott/Services/api_service.dart';
import 'package:myott/Services/setting_service.dart';

import '../../Setting/Models/PackageModel.dart';

class SubscriptionController extends GetxController {
  final SettingService settingService = Get.put(SettingService(ApiService()));

  var plans = <PackageModel>[].obs; // Rx List for live updates
  var isLoading = true.obs;
  var selectedPlanIndex = Rxn<int>(); // Nullable Rx<int>

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionPlans(); // Fetch data when controller is initialized
  }

  Future<void> fetchSubscriptionPlans() async {
    try {
      isLoading.value = true;
      final fetchedPlans = await settingService.fetchPackages();

      print("Fetched Plans: $fetchedPlans"); // Debugging line

      if (fetchedPlans.isNotEmpty) {
        plans.assignAll(fetchedPlans);
      }
    } catch (e) {
      print("Error fetching plans: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void selectPlan(int index) {
    selectedPlanIndex.value = index;
  }
}
