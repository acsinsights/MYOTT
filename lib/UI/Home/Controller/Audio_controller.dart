import 'package:get/get.dart';
import 'package:myott/Services/Home_service.dart';
import '../Model/Audio_Model.dart';

class AudioController extends GetxController {
  var isLoading = false.obs;


  final List<int> colors = [
    0xFF3B3B98,
    0xFF8D4E3F,
    0xFF5D5D81,
    0xFF725285,
    0xFFA97E36,
    0xFF3B8D78,
  ];

  @override
  void onInit() {
    super.onInit();
  }


}
