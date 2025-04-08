import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

String formatDate(String dateStr) {
  try {
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat('dd MMM yyyy').format(dateTime); // Example: 25 Feb 2025
  } catch (e) {
    return "Unknown Date"; // Fallback in case of an error
  }
}

enum PaymentType { subscription, ppv, coins }

enum ContentType { M, S, V, A }

enum MediaType { movie, series, video, Audio }

void showSnackbar(String title, String message, {bool isError = false}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: isError ? Colors.red : Colors.green,
    colorText: Colors.white,
    margin: const EdgeInsets.all(12),
    borderRadius: 8,
    duration: const Duration(seconds: 2),
    icon: Icon(
      isError ? Icons.error : Icons.check_circle,
      color: Colors.white,
    ),
  );
}

void showLoading({String? message}) {
  if (Get.isDialogOpen == true) return;

  Get.dialog(
    Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: Colors.redAccent),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(message, style: const TextStyle(color: Colors.white)),
          ],
        ],
      ),
    ),
    barrierDismissible: false,
    useSafeArea: true,
    barrierColor: Colors.black.withOpacity(0.5),
  );
}

void dismissLoading() {
  if (Get.isDialogOpen == true) {
    Navigator.of(Get.overlayContext!).pop(); // ✅ Safe dismiss
  }
}






