import 'package:get/get.dart';
import '../../../../services/Setting_service.dart';
import '../Model/payment_history_model.dart';


class PaymentHistoryController extends GetxController {
  final SettingService _settingService = SettingService();

  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;
  RxList<PaymentHistoryData> paymentHistoryList = <PaymentHistoryData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPaymentHistory();
  }

  Future<void> fetchPaymentHistory() async {
    try {
      isLoading(true);
      errorMessage('');

      PaymentHistoryModel response = await _settingService.getPaymentHistory();
      paymentHistoryList.assignAll(response.data);

    } catch (e) {
      errorMessage("Failed to load payment history.");
    } finally {
      isLoading(false);
    }
  }
}
