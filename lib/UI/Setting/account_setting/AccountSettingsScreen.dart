import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myott/UI/Profile/screens/SubscriptionPackage/subscription_page.dart';

class AccountSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Account Settings', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xB0EDB71C),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFEDB71C),
                  width: 1.2,
                ),
              ),
              child: Row(
                children: [
                  Image.asset("assets/Icons/crown.png", height: 30),
                  const SizedBox(width: 12), // Adjusted spacing
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Subscribe to enjoy more",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13, // Slightly increased font size
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Unlock Exclusive Features Today",
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 11, // Slightly increased for readability
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      textStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    onPressed: () {
                      Get.to(SubscriptionScreen());
                    },
                    child: Text("Upgrade"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Device Information
            Text(
              'Your Device',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'vivo(V2334)',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Last used: Just now',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            Spacer(),
            // Delete Account
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Delete Account',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
