import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../services/Setting_service.dart';
import '../../../../services/api_endpoints.dart';
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
  Future<void> downloadAndOpenPDF(int orderId) async {
    try {
      print("📌 Starting PDF download for Order ID: $orderId");

      String url = APIEndpoints.invoice(orderId);
      print("🔗 PDF URL: $url");

      String fileName = "Invoice_$orderId.pdf";

      Directory? downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = Directory('/storage/emulated/0/Download');
        if (!downloadsDir.existsSync()) {
          downloadsDir.createSync(recursive: true);
        }
      } else {
        downloadsDir = await getApplicationDocumentsDirectory();
      }

      String filePath = "${downloadsDir.path}/$fileName";
      print("📌 File path: $filePath");

      Dio dio = Dio();
      var response = await dio.download(url, filePath);
      print("✅ PDF downloaded at: $filePath, Status Code: ${response.statusCode}");

      // 🔥 Ensure file exists before opening
      File file = File(filePath);
      if (!await file.exists()) {
        print("❌ File not found after download!");
        return;
      }

      OpenResult result = await OpenFilex.open(filePath);
      print("📌 OpenFile result: ${result.type}");

      if (result.type != ResultType.done) {
        print("❌ Failed to open PDF: ${result.message}");
      }
    } catch (e) {
      print("❌ Error downloading PDF: $e");
    }
  }

  /// ✅ Request permission with system dialog & manual settings if permanently denied
  Future<bool> requestStoragePermission() async {
    print("🔹 Checking storage permission...");

    PermissionStatus status = await Permission.storage.request();
    print("🔹 Permission status: $status");

    if (status.isGranted) {
      print("✅ Permission granted!");
      return true;
    } else if (status.isPermanentlyDenied) {
      print("⚠️ Permission permanently denied. Showing settings dialog...");

      Get.dialog(
        AlertDialog(
          title: const Text("Permission Required"),
          content: const Text("Storage permission is needed to save invoices. Please enable it in settings."),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
            TextButton(onPressed: () => openAppSettings(), child: const Text("Open Settings")),
          ],
        ),
      );
      return false;
    } else {
      print("❌ Permission denied!");
      return false;
    }
  }
}
