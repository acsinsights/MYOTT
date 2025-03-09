import 'package:get/get.dart';
import 'package:myott/services/api_service.dart';
import 'package:myott/services/auth_service.dart';
import 'package:myott/UI/Auth/Controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiService(), permanent: true);
    Get.put(AuthService(Get.find<ApiService>()), permanent: true);
    Get.put(AuthController(Get.find<AuthService>()), permanent: true);
  }
}
