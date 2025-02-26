import 'package:get/get.dart';
import '../../../Services/Setting_service.dart';
import 'Faq/Model/FAQModel.dart';

class SettingController extends GetxController {
  final SettingService _settingService;

  var isLoading = false.obs;

  SettingController(this._settingService);

  @override
  void onInit() {
    super.onInit();
  }

}
