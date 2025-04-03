import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myott/Core/Utils/app_common.dart';
import 'package:myott/UI/Components/custom_button.dart';
import 'package:myott/UI/Setting/Setting_Controller.dart';

class AddSupportPage extends StatefulWidget {
  const AddSupportPage({super.key});

  @override
  _AddSupportPageState createState() => _AddSupportPageState();
}

class _AddSupportPageState extends State<AddSupportPage> {
  final SettingController controller = Get.find<SettingController>();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Add Support", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Support Type Display
            Obx(() {
              final supportType = controller.selectedSupportType.value;
              return Text(
                supportType != null
                    ? "Support Type: ${supportType.name}"
                    : "No support type selected",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),

            const SizedBox(height: 16),

            // Message Input Field
            TextField(
              controller: messageController,
              style: const TextStyle(color: Colors.white),
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Enter your message",
                hintStyle: const TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Submit Button
            Obx(() {
              return CustomButton(
                width: double.infinity,
                text: controller.isSubmitting.value
                    ? "Submitting..."
                    : "Submit",
                onPressed: controller.isSubmitting.value
                    ? null  // Disable button when submitting
                    : () async {
                  if (messageController.text.isNotEmpty) {
                    controller.isSubmitting.value = true;  // Start Loading

                    try {
                      await controller.submitSupportRequest(messageController.text);
                      messageController.clear();  // ✅ Clear TextField after submission
                    } catch (e) {
                      showSnackbar("Error", "Failed to submit support request", isError: true);
                    } finally {
                      controller.isSubmitting.value = false;  // Stop Loading
                    }
                  } else {
                    showSnackbar("Error", "Message cannot be empty", isError: true);
                  }
                },
                child: controller.isSubmitting.value
                    ? const CircularProgressIndicator(color: Colors.white) // ✅ Show loading
                    : null,  // Default button text
              );
            }),
          ],
        ),
      ),
    );
  }
}
