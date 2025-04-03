import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/UI/Setting/Setting_Controller.dart';

import 'AddSupportPage.dart';

class SupportTypePage extends StatelessWidget {
  final SettingController controller = Get.put(SettingController());

  SupportTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchSupportTypes();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Support", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.supportTypeList.isEmpty) {
          return const Center(child: Text("No support types available", style: TextStyle(color: Colors.white)));
        }

        return ListView.builder(
          itemCount: controller.supportTypeList.length,
          itemBuilder: (context, index) {
            var supportType = controller.supportTypeList[index];
            return Card(
              color: Colors.grey[900],
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(supportType.name, style: const TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70),
                onTap: () {
                  controller.setSelectedSupportType(supportType);
                  Get.to(() => AddSupportPage());
                },
              ),
            );
          },
        );
      }),
    );
  }
}
