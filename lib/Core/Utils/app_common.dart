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

