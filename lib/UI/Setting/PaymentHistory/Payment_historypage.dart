import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controller/PaymentHistorycontroller.dart';

class PaymentHistoryPage extends StatelessWidget {
  const PaymentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentHistoryController controller = Get.put(PaymentHistoryController());

    return Scaffold(
      backgroundColor: Colors.black, // Dark Theme
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("Payment History",),
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value, style: TextStyle(color: Colors.white)));
        }

        if (controller.paymentHistoryList.isEmpty) {
          return const Center(child: Text("No payment history found", style: TextStyle(color: Colors.white)));
        }

        return ListView.builder(
          itemCount: controller.paymentHistoryList.length,
          itemBuilder: (context, index) {
            var payment = controller.paymentHistoryList[index];

            return Card(
              color: Colors.grey[900], // Dark Card
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: Text(payment.orderId, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Invoice: ${payment.invoiceNo}", style: const TextStyle(color: Colors.white70)),
                    Text("Transaction: ${payment.transactionId}", style: const TextStyle(color: Colors.white70)),
                    Text("Payment Method: ${payment.paymentMethod}", style: const TextStyle(color: Colors.white70)),
                    Text("Price: ₹${payment.price} | Offer: ₹${payment.offerPrice}",
                        style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    Text("Status: ${payment.transactionStatus}",
                        style: TextStyle(
                          color: payment.transactionStatus == "success" ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Start: ${payment.startDate.toString().split(' ')[0]}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      "End: ${payment.endDate.toString().split(' ')[0]}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
